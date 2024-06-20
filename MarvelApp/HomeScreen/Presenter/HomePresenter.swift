//
//  HomePresenter.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

final class HomePresenter {
    // MARK: - Private Properties
    private let router: HomeRouter
    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var dataSource: HomeCollectionViewDataSource?
    private var homeViewModel = HomeViewModel(coverComics: [], actualComics: [], characters: [], monthNoveltiesComics: [])
    private weak var ui: HomeViewProtocol?
    
    private enum ArrayType: CaseIterable {
        case coverComics
        case actualComics
        case characters
        case monthNoveltiesComics
    }
    
    // MARK: - Initialization
    init(router: HomeRouter, coreDataService: CoreDataServiceProtocol, networkService: NetworkServiceProtocol) {
        self.router = router
        self.coreDataService = coreDataService
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: HomeViewProtocol) {
        self.ui = ui
        loadData()
    }
    
    func uiWillAppear(animated: Bool) {
        ui?.setNavigationBarHidden(true, animated: animated)
    }
    
    func uiWillDisappear(animated: Bool) {
        ui?.setNavigationBarHidden(false, animated: animated)
    }
    
    func didTapContent(at indexPath: IndexPath) {
        guard indexPath.section < ArrayType.allCases.count else { return }
        
        let section = ArrayType.allCases[indexPath.section]
        let selectedContentID: Int
        let selectedContentType: ContentType
        
        switch section {
        case .coverComics:
            guard indexPath.item < homeViewModel.coverComics.count else { return }
            selectedContentID = homeViewModel.coverComics[indexPath.item].id
            selectedContentType = .comic
        case .actualComics:
            guard indexPath.item < homeViewModel.actualComics.count else { return }
            selectedContentID = homeViewModel.actualComics[indexPath.item].id
            selectedContentType = .comic
        case .characters:
            guard indexPath.item < homeViewModel.characters.count else { return }
            selectedContentID = homeViewModel.characters[indexPath.item].id
            selectedContentType = .character
        case .monthNoveltiesComics:
            guard indexPath.item < homeViewModel.monthNoveltiesComics.count else { return }
            selectedContentID = homeViewModel.monthNoveltiesComics[indexPath.item].id
            selectedContentType = .comic
        }
        
        router.showContentDetailViewController(
            for: selectedContentType,
            with: selectedContentID,
            coreDataService: coreDataService,
            networkService: networkService
        )
    }
}

// MARK: - Private Extension
private extension HomePresenter {
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        ui?.startLoadingAnimation()
        getHomeScreenContent(dispatchGroup)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.ui?.stopLoadingAnimation()
            self?.setupUIDataSource()
        }
    }
    
    func getHomeScreenContent(_ dispatchGroup: DispatchGroup) {
        getContent(for: .coverComics, from: .weekNoveltiesComics, dispatchGroup: dispatchGroup) { Comic(with: $0) }
        getContent(for: .actualComics, from: .comics, dispatchGroup: dispatchGroup) { Comic(with: $0) }
        getContent(for: .characters, from: .characters, dispatchGroup: dispatchGroup) { Character(with: $0) }
        getContent(for: .monthNoveltiesComics, from: .monthNoveltiesComics, dispatchGroup: dispatchGroup) {
            Comic(with: $0)
        }
    }
    
    private func getContent<T: Decodable>(
        for arrayType: ArrayType,
        from endpoint: Endpoint,
        dispatchGroup: DispatchGroup,
        mapResult: @escaping (T) -> DescriptableProtocol
    ) {
        dispatchGroup.enter()
        networkService.fetch(from: endpoint) { [weak self] (result: Result<BaseResponseDTO<T>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    self?.router.showAlertController()
                case .success(let baseResponseDTO):
                    let contents = baseResponseDTO.data.results.map { mapResult($0) }
                    
                    switch arrayType {
                    case .coverComics:
                        self?.homeViewModel.coverComics = contents
                    case .actualComics:
                        self?.homeViewModel.actualComics = contents
                    case .characters:
                        self?.homeViewModel.characters = contents
                    case .monthNoveltiesComics:
                        self?.homeViewModel.monthNoveltiesComics = contents
                    }
                    
                    contents.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: arrayType, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    private func fetchAndSetImage(
        from urlString: String,
        index: Int,
        arrayType: ArrayType,
        dispatchGroup: DispatchGroup
    ) {
        dispatchGroup.enter()
        networkService.fetchImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    break
                case .success(let image):
                    switch arrayType {
                    case .coverComics:
                        self?.homeViewModel.coverComics[index].image = image
                    case .actualComics:
                        self?.homeViewModel.actualComics[index].image = image
                    case .characters:
                        self?.homeViewModel.characters[index].image = image
                    case .monthNoveltiesComics:
                        self?.homeViewModel.monthNoveltiesComics[index].image = image
                    }
                }
            }
        }
    }
    
    func setupUIDataSource() {
        dataSource = HomeCollectionViewDataSource(homeViewModel)
        ui?.setupDataSource(with: dataSource)
    }
}
