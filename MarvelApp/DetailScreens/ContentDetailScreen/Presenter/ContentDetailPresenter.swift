//
//  ContentDetailPresenter.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

final class ContentDetailPresenter {
    // MARK: - Private Properties
    private let contentType: ContentType
    private let contentID: Int
    private let router: ContentDetailRouter
    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var dataSource: ContentDetailCollectionViewDataSource?
    private weak var ui: ContentDetailViewProtocol?
    
    private lazy var contentDetailViewModel: ContentDetailViewModel = {
        let contentDetailViewModel = ContentDetailViewModel(
            isFavorite: false,
            firstContentHeader: contentType.firstAdditionalContent.rawValue,
            secondContentHeader: contentType.secondAdditionalContent.rawValue,
            description: nil,
            firstContent: [],
            secondContent: []
        )
        return contentDetailViewModel
    }()
    
    private enum ArrayType: CaseIterable {
        case description
        case firstContent
        case secondContent
    }
    
    // MARK: - Initialization
    init(
        contentType: ContentType,
        contentID: Int,
        router: ContentDetailRouter,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.contentType = contentType
        self.contentID = contentID
        self.router = router
        self.coreDataService = coreDataService
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: ContentDetailViewProtocol) {
        self.ui = ui
        ui.startLoadingAnimation()
        ui.disableRightBarButton()
        
        loadDataFromDataBase()
    }
    
    func uiWillAppear() {
        checkIfIsFavorite()
    }
    
    func didTapRightBarButtonItem() {
        ui?.disableRightBarButton()
        
        if contentDetailViewModel.isFavorite {
            removeFromFavorite()
            ui?.setNotFavoriteButtonType()
        } else {
            saveToFavorite()
            ui?.setFavoriteButtonType()
        }
    }
    
    func didTapContent(at indexPath: IndexPath) {
        guard indexPath.section < ArrayType.allCases.count else { return }
        
        let section = ArrayType.allCases[indexPath.section]
        let selectedContentID: Int
        
        switch section {
        case .description:
            break
        case .firstContent:
            guard indexPath.item < contentDetailViewModel.firstContent.count else { return }
            selectedContentID = contentDetailViewModel.firstContent[indexPath.item].id
            router.showContentDetailViewController(
                for: contentType.firstAdditionalContent,
                with: selectedContentID,
                coreDataService: coreDataService,
                networkService: networkService
            )
        case .secondContent:
            guard indexPath.item < contentDetailViewModel.secondContent.count else { return }
            selectedContentID = contentDetailViewModel.secondContent[indexPath.item].id
            router.showContentDetailViewController(
                for: contentType.secondAdditionalContent,
                with: selectedContentID,
                coreDataService: coreDataService,
                networkService: networkService
            )
        }
    }
}

// MARK: - Private Extension Data Base Fetches
private extension ContentDetailPresenter {
    func saveToFavorite() {
        contentDetailViewModel.isFavorite = true
        switch contentType {
        case .comic:
            guard var comic = contentDetailViewModel.description as? Comic else { return }
            comic.firstAdditionalContent = contentDetailViewModel.firstContent
            comic.secondAdditionalContent = contentDetailViewModel.secondContent
            coreDataService.add(comic: comic) { [weak ui] in
                DispatchQueue.main.async {
                    ui?.enableRightBarButton()
                }
            }
        case .character:
            guard var character = contentDetailViewModel.description as? Character else { return }
            character.firstAdditionalContent = contentDetailViewModel.firstContent
            character.secondAdditionalContent = contentDetailViewModel.secondContent
            coreDataService.add(character: character) { [weak ui] in
                DispatchQueue.main.async {
                    ui?.enableRightBarButton()
                }
            }
        case .series:
            guard var series = contentDetailViewModel.description as? Series else { return }
            series.firstAdditionalContent = contentDetailViewModel.firstContent
            series.secondAdditionalContent = contentDetailViewModel.secondContent
            coreDataService.add(series: series) { [weak ui] in
                DispatchQueue.main.async {
                    ui?.enableRightBarButton()
                }
            }
        case .event:
            guard var event = contentDetailViewModel.description as? Event else { return }
            event.firstAdditionalContent = contentDetailViewModel.firstContent
            event.secondAdditionalContent = contentDetailViewModel.secondContent
            coreDataService.add(event: event) { [weak ui] in
                DispatchQueue.main.async {
                    ui?.enableRightBarButton()
                }
            }
        case .creator:
            guard var creator = contentDetailViewModel.description as? Creator else { return }
            creator.firstAdditionalContent = contentDetailViewModel.firstContent
            creator.secondAdditionalContent = contentDetailViewModel.secondContent
            coreDataService.add(creator: creator) { [weak ui] in
                DispatchQueue.main.async {
                    ui?.enableRightBarButton()
                }
            }
        }
    }
    
    func removeFromFavorite() {
        contentDetailViewModel.isFavorite = false
        switch contentType {
        case .comic:
            guard let comic = contentDetailViewModel.description as? Comic else { return }
            coreDataService.removeComic(by: comic.uuid)
        case .character:
            guard let character = contentDetailViewModel.description as? Character else { return }
            coreDataService.removeCharacter(by: character.uuid)
        case .series:
            guard let series = contentDetailViewModel.description as? Series else { return }
            coreDataService.removeSeries(by: series.uuid)
        case .event:
            guard let event = contentDetailViewModel.description as? Event else { return }
            coreDataService.removeEvent(by: event.uuid)
        case .creator:
            guard let creator = contentDetailViewModel.description as? Creator else { return }
            coreDataService.removeCreator(by: creator.uuid)
        }
        ui?.enableRightBarButton()
    }
    
    func loadDataFromDataBase() {
        switch contentType {
        case .comic:
            coreDataService.fetchComic(with: contentID) { [weak self] result in
                self?.setupViewModelWith(result)
            }
        case .character:
            coreDataService.fetchCharacter(with: contentID) { [weak self] result in
                self?.setupViewModelWith(result)
            }
        case .creator:
            coreDataService.fetchCreator(with: contentID) { [weak self] result in
                self?.setupViewModelWith(result)
            }
        case .series:
            coreDataService.fetchSeries(with: contentID) { [weak self] result in
                self?.setupViewModelWith(result)
            }
        case .event:
            coreDataService.fetchEvent(with: contentID) { [weak self] result in
                self?.setupViewModelWith(result)
            }
        }
    }
    
    func setupViewModelWith<T: DescriptableProtocol>(_ result: Result<T, Error>) {
        switch result {
        case .success(let content):
            contentDetailViewModel.description = content
            contentDetailViewModel.firstContent = content.firstAdditionalContent ?? []
            contentDetailViewModel.secondContent = content.secondAdditionalContent ?? []
            contentDetailViewModel.isFavorite = true
            ui?.setFavoriteButtonType()
            ui?.stopLoadingAnimation()
            ui?.enableRightBarButton()
            setupUIDataSource()
        case .failure(let error):
            print(#function, error.localizedDescription)
            loadDataFromNetwork()
        }
    }
}

// MARK: Private Extension Network Fetches
private extension ContentDetailPresenter {
    func loadDataFromNetwork() {
        let dispatchGroup = DispatchGroup()
        
        switch contentType {
        case .comic:
            getComicContent(dispatchGroup)
        case .character:
            getCharacterContent(dispatchGroup)
        case .creator:
            getCreatorContent(dispatchGroup)
        case .series:
            getSeriesContent(dispatchGroup)
        case .event:
            getEventsContent(dispatchGroup)
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.ui?.stopLoadingAnimation()
            self?.ui?.enableRightBarButton()
            self?.setupUIDataSource()
        }
    }
    
    func getComicContent(_ dispatchGroup: DispatchGroup) {
        getDescriptionContent(from: .comicID(String(contentID)), dispatchGroup: dispatchGroup) { Comic(with: $0) }
        getAdditionalContent(for: .firstContent, from: .charactersFromComicID(String(contentID)), dispatchGroup: dispatchGroup) {
            Character(with: $0)
        }
        getAdditionalContent(for: .secondContent, from: .creatorsWithComicID(String(contentID)), dispatchGroup: dispatchGroup) {
            Creator(with: $0)
        }
    }
    
    func getCreatorContent(_ dispatchGroup: DispatchGroup) {
        getDescriptionContent(from: .creatorID(String(contentID)), dispatchGroup: dispatchGroup) { Creator(with: $0) }
        getAdditionalContent(for: .firstContent, from: .comicsWithCreatorID(String(contentID)), dispatchGroup: dispatchGroup) {
            Comic(with: $0)
        }
        getAdditionalContent(for: .secondContent, from: .eventsWithCreatorID(String(contentID)), dispatchGroup: dispatchGroup) {
            Event(with: $0)
        }
    }
    
    func getCharacterContent(_ dispatchGroup: DispatchGroup) {
        getDescriptionContent(from: .characterID(String(contentID)), dispatchGroup: dispatchGroup) { Character(with: $0) }
        getAdditionalContent(for: .firstContent, from: .comicsWithCharacterID(String(contentID)), dispatchGroup: dispatchGroup) {
            Comic(with: $0)
        }
        getAdditionalContent(for: .secondContent, from: .seriesWithCharacterID(String(contentID)), dispatchGroup: dispatchGroup) {
            Series(with: $0)
        }
    }
    
    func getSeriesContent(_ dispatchGroup: DispatchGroup) {
        getDescriptionContent(from: .seriesID(String(contentID)), dispatchGroup: dispatchGroup) { Series(with: $0) }
        getAdditionalContent(for: .firstContent, from: .charactersWithSeriesID(String(contentID)), dispatchGroup: dispatchGroup) {
            Character(with: $0)
        }
        getAdditionalContent(for: .secondContent, from: .comicsWithSeriesID(String(contentID)), dispatchGroup: dispatchGroup) {
            Comic(with: $0)
        }
    }
    
    func getEventsContent(_ dispatchGroup: DispatchGroup) {
        getDescriptionContent(from: .eventID(String(contentID)), dispatchGroup: dispatchGroup) { Event(with: $0) }
        getAdditionalContent(for: .firstContent, from: .comicsWithEventID(String(contentID)), dispatchGroup: dispatchGroup) {
            Comic(with: $0)
        }
        getAdditionalContent(for: .secondContent, from: .creatorsWithEventID(String(contentID)), dispatchGroup: dispatchGroup) {
            Creator(with: $0)
        }
    }
    
    func setupUIDataSource() {
        dataSource = ContentDetailCollectionViewDataSource(contentDetailViewModel)
        ui?.setupDataSource(with: dataSource)
    }
    
    func getDescriptionContent<T: Decodable>(
        from endpoint: Endpoint,
        dispatchGroup: DispatchGroup,
        mapResult: @escaping (T) -> DescriptableProtocol
    ) {
        dispatchGroup.enter()
        networkService.fetch(from: endpoint) { [weak self] (result: Result<BaseResponseDTO<T>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure(let error):
                    print(#function, error.localizedDescription)
                case .success(let baseResponseDTO):
                    guard let content = baseResponseDTO.data.results.map({ mapResult($0) }).first
                    else { return }
                    
                    self?.contentDetailViewModel.description = content
                    self?.fetchAndSetImage(from: content.thumbnailURL, index: 0, arrayType: .description, dispatchGroup: dispatchGroup)
                }
            }
        }
    }
    
    private func getAdditionalContent<T: Decodable>(
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
                    case .description:
                        break
                    case .firstContent:
                        self?.contentDetailViewModel.firstContent = contents.map { .init(with: $0) }
                    case .secondContent:
                        self?.contentDetailViewModel.secondContent = contents.map { .init(with: $0) }
                    }
                    contents.enumerated().forEach {
                        self?.fetchAndSetImage(from: $1.thumbnailURL, index: $0, arrayType: arrayType, dispatchGroup: dispatchGroup)
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
                    break
                case .success(let image):
                    switch arrayType {
                    case .description:
                        self?.contentDetailViewModel.description?.image = image
                    case .firstContent:
                        self?.contentDetailViewModel.firstContent[index].image = image
                    case .secondContent:
                        self?.contentDetailViewModel.secondContent[index].image = image
                    }
                }
            }
        }
    }
}

// MARK: - Private Extension
private extension ContentDetailPresenter {
    func checkIfIsFavorite() {
        switch contentType {
        case .comic:
            coreDataService.fetchComic(with: contentID) { updateIsFavoriteState($0) }
        case .character:
            coreDataService.fetchCharacter(with: contentID) { updateIsFavoriteState($0) }
        case .creator:
            coreDataService.fetchCreator(with: contentID) { updateIsFavoriteState($0) }
        case .series:
            coreDataService.fetchSeries(with: contentID) { updateIsFavoriteState($0) }
        case .event:
            coreDataService.fetchEvent(with: contentID) { updateIsFavoriteState($0) }
        }
    }
    
    func updateIsFavoriteState<T: DescriptableProtocol>(_ result: Result<T, Error>) {
        switch result {
        case .success:
            contentDetailViewModel.isFavorite = true
            ui?.setFavoriteButtonType()
        case .failure:
            contentDetailViewModel.isFavorite = false
            ui?.setNotFavoriteButtonType()
        }
    }
}
