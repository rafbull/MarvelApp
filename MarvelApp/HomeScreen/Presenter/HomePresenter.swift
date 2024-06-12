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
    private var networkService: NetworkServiceProtocol
    private var dataSource: HomeCollectionViewDataSource?
    private var homeViewModel = HomeViewModel(coverComics: [], actualComics: [], characters: [], monthNoveltiesComics: [])
    private weak var ui: HomeViewProtocol?
    
    private enum ArrayType {
        case coverComics
        case actualComics
        case characters
        case monthNoveltiesComics
    }
    
    // MARK: - Initialization
    init(router: HomeRouter, networkService: NetworkServiceProtocol) {
        self.router = router
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
    
    func didTapComic(at index: Int) {

    }
    
    func didTapCharacter(at index: Int) {
        
    }
}

// MARK: - Private Extension
private extension HomePresenter {
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        ui?.startLoadingAnimation()
        getCoverComicsNovelties(dispatchGroup)
        getActualComics(dispatchGroup)
        getCharacters(dispatchGroup)
        getComicsMonthNovelties(dispatchGroup)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.ui?.stopLoadingAnimation()
            self?.setupUIDataSource()
        }
    }
    
    func getCoverComicsNovelties(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetch(from: .weekNoveltiesComics) { [weak self] (result: Result<BaseResponseDTO<ComicDTO>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    print("getCoverComicsNovelties Bad")
                case .success(let baseResponseDTO):
                    let comics = baseResponseDTO.data.results.map { Comic(with: $0) }
                    
                    self?.homeViewModel.coverComics = comics.map { .init(id: $0.id, title: $0.title) }
                    comics.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: .coverComics, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    func getActualComics(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetch(from: .comics) { [weak self] (result: Result<BaseResponseDTO<ComicDTO>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    print("Actual Comic Bad")
                case .success(let baseResponseDTO):
                    let comics = baseResponseDTO.data.results.map { Comic(with: $0) }
                    
                    self?.homeViewModel.actualComics = comics.map { .init(id: $0.id, title: $0.title) }
                    comics.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: .actualComics, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    func getCharacters(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetch(from: .characters) { [weak self] (result: Result<BaseResponseDTO<CharacterDTO>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    print("Character Bad")
                case .success(let baseResponseDTO):
                    let characters = baseResponseDTO.data.results.map { Character(with: $0) }
                    
                    self?.homeViewModel.characters = characters.map { .init(id: $0.id, name: $0.name)}
                    characters.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: .characters, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    func getComicsMonthNovelties(_ dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetch(from: .monthNoveltiesComics) { [weak self] (result: Result<BaseResponseDTO<ComicDTO>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    print("getCoverComicsNovelties Bad")
                case .success(let baseResponseDTO):
                    let comics = baseResponseDTO.data.results.map { Comic(with: $0) }
                    
                    self?.homeViewModel.monthNoveltiesComics = comics.map { .init(id: $0.id, title: $0.title) }
                    comics.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: .monthNoveltiesComics, dispatchGroup: dispatchGroup)
                    }
                }
            }
        }
    }
    
    private func fetchAndSetImage(from urlString: String, index: Int, arrayType: ArrayType, dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        networkService.fetchImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure:
                    print("Bad Image")
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

