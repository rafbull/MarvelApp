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
    private let networkService: NetworkServiceProtocol
    private var dataSource: SearchTableViewDataSource?
    private var searchContentViewModels = [SearchContentViewModel]()
    private var searchResultContentViewModels = [SearchResultContentViewModel]()
    private weak var ui: SearchViewProtocol?
    private weak var searchResultUI: SearchResultViewProtocol?
    
    // MARK: - Initialization
    init(router: SearchRouter, dataManager: SearchDataManagerProtocol, networkService: NetworkServiceProtocol) {
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
        router.showContentListViewController(with: contentType, networkService)
    }
    
    func didTapSearchResultContent(at index: Int) {
        guard index < searchResultContentViewModels.count else { return }
        let searchResultContentID = searchResultContentViewModels[index].id
        router.showContentDetailViewController(
            for: .character,
            with: searchResultContentID,
            networkService: networkService
        )
    }
    
    func didEnterSerchText(_ searchText: String) {
        guard searchText.isEmpty == false else { return }
        getSearchResults(for: searchText)
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
            case .success(let searchContentDTOArray):
                let searchContentViewModels = searchContentDTOArray.map { SearchContentViewModel(with: $0) }
                self?.searchContentViewModels = searchContentViewModels
                self?.dataSource = SearchTableViewDataSource(searchContentViewModels)
                self?.setupUIDataSource()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupUIDataSource() {
        guard let dataSource = dataSource else { return }
        ui?.setupDataSource(with: dataSource)
    }
    
    func getSearchResults(for searchText: String) {
        networkService.fetch(from: .character(searchText)) { [weak self] (result: Result<BaseResponseDTO<CharacterDTO>, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    print("getSearchResults Bad")
                case .success(let baseResponseDTO):
                    let characters = baseResponseDTO.data.results.map { Character(with: $0) }
                    self?.searchResultContentViewModels = characters.map { .init(id: $0.id, title: $0.name)}
                    self?.searchResultUI?.reloadData()
                }
            }
        }
    }
}
