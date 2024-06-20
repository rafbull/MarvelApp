//
//  ContentListPresenter.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

final class ContentListPresenter {
    // MARK: - Private Properties
    private let contentType: ContentType
    private let router: ContentListRouter
    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var dataSource: ContentListCollectionViewDataSource?
    private var contentListViewModels = [ContentListViewModel]()
    private weak var ui: ContentListViewProtocol?
    
    // MARK: - Initialization
    init(
        contentType: ContentType,
        router: ContentListRouter,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.coreDataService = coreDataService
        self.contentType = contentType
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: ContentListViewProtocol) {
        self.ui = ui
        ui.setTitle(contentType.rawValue)
        loadData()
    }
    
    func didTapContent(at index: Int) {
        guard index < contentListViewModels.count else { return }
        let contentId = contentListViewModels[index].id
        
        router.showContentDetailViewController(
            for: contentType,
            with: contentId,
            coreDataService: coreDataService,
            networkService: networkService
        )
    }
}

// MARK: - Private Extension
private extension ContentListPresenter {
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        ui?.startLoadingAnimation()
        
        switch contentType {
        case .comic:
            getContent(from: .comics, dispatchGroup: dispatchGroup) { Comic(with: $0) }
        case .character:
            getContent(from: .characters, dispatchGroup: dispatchGroup) { Character(with: $0) }
        case .creator:
            getContent(from: .creators, dispatchGroup: dispatchGroup) { Creator(with: $0) }
        case .series:
            getContent(from: .series, dispatchGroup: dispatchGroup) { Series(with: $0) }
        case .event:
            getContent(from: .events, dispatchGroup: dispatchGroup) { Event(with: $0) }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.ui?.stopLoadingAnimation()
            self?.setupUIDataSource()
        }
    }
    
    private func getContent<T: Decodable>(
        from endpoint: Endpoint,
        dispatchGroup: DispatchGroup,
        mapResult: @escaping (T) -> DescriptableProtocol
    ) {
        dispatchGroup.enter()
        networkService.fetch(
            from: endpoint
        ) { [weak self] (result: Result<BaseResponseDTO<T>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    self?.router.showAlertController()
                case .success(let baseResponseDTO):
                    let contents = baseResponseDTO.data.results.map { mapResult($0) }
                    self?.contentListViewModels = contents.map { .init(id: $0.id, title: $0.title) }
                    
                    contents.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    private func fetchAndSetImage(from urlString: String, index: Int, dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetchImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    break
                case .success(let image):
                    self?.contentListViewModels[index].image = image
                }
            }
        }
    }
    
    func setupUIDataSource() {
        dataSource = ContentListCollectionViewDataSource(contentListViewModels)
        ui?.setupDataSource(with: dataSource)
    }
}
