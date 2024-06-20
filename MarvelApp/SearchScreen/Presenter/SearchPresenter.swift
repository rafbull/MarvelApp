//
//  SearchPresenter.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

final class SearchPresenter {
    // MARK: - Private Properties
    private let router: SearchRouter
    private let dataManager: SearchDataManagerProtocol
    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var dataSource: SearchTableViewDataSource?
    private var searchContentViewModels = [SearchContentViewModel]()
    private var searchResultContentViewModels = [SearchResultContentViewModel]()
    private weak var ui: SearchViewProtocol?
    private weak var searchResultUI: SearchResultViewProtocol?
    
    // MARK: - Initialization
    init(
        router: SearchRouter,
        dataManager: SearchDataManagerProtocol,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.coreDataService = coreDataService
        self.router = router
        self.dataManager = dataManager
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: SearchViewProtocol) {
        self.ui = ui
        loadData()
    }
    
    func didLoad(searchResultUI: SearchResultViewProtocol) {
        self.searchResultUI = searchResultUI
    }
    
    func didTapContent(at index: Int) {
        guard index < searchContentViewModels.count else { return }
        let contentType = ContentType.allCases[index]
        router.showContentListViewController(
            with: contentType,
            coreDataService: coreDataService,
            networkService: networkService
        )
    }
    
    func didTapSearchResultContent(at index: Int) {
        guard index < searchResultContentViewModels.count else { return }
        let searchResultContentID = searchResultContentViewModels[index].id
        router.showContentDetailViewController(
            for: .character,
            with: searchResultContentID,
            coreDataService: coreDataService,
            networkService: networkService
        )
    }
    
    func didEnterSerchText(_ searchText: String) {
        guard searchText.isEmpty == false else { return }
        let dispatchGroup = DispatchGroup()
        getSearchResults(for: searchText, dispatchGroup: dispatchGroup)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.searchResultUI?.reloadData()
        }
    }
    
    func getSearchResultTableViewRowsCount() -> Int {
        searchResultContentViewModels.count
    }
    
    func getSearchResultContent(at index: Int) -> SearchResultContentViewModel? {
        guard index < searchResultContentViewModels.count else { return nil }
        return searchResultContentViewModels[index]
    }
}

// MARK: - Private Extension
private extension SearchPresenter {
    func loadData() {
        dataManager.loadData { [weak self] result in
            switch result {
            case .failure:
                break
            case .success(let searchContentDTOArray):
                self?.searchContentViewModels = searchContentDTOArray.map { .init(with: $0) }
                self?.setupUIDataSource()
            }
        }
    }
    
    func setupUIDataSource() {
        dataSource = SearchTableViewDataSource(searchContentViewModels)
        ui?.setupDataSource(with: dataSource)
    }
    
    func getSearchResults(for searchText: String, dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetch(
            from: .character(searchText)
        ) { [weak self] (result: Result<BaseResponseDTO<CharacterDTO>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    break
                case .success(let baseResponseDTO):
                    let characters = baseResponseDTO.data.results.map { Character(with: $0) }
                    self?.searchResultContentViewModels = characters.map { .init(id: $0.id, title: $0.name) }
                    
                    characters.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    func fetchAndSetImage(from urlString: String, index: Int, dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetchImage(from: urlString) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    break
                case .success(let image):
                    guard index < self.searchResultContentViewModels.count else { return }
                    self.searchResultContentViewModels[index].image = image
                }
            }
        }
    }
}
