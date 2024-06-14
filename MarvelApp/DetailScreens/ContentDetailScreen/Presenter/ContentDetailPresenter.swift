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
    private let networkService: NetworkServiceProtocol
    private var dataSource: ContentDetailCollectionViewDataSource?
    private weak var ui: ContentDetailViewProtocol?
    
    private lazy var contentDetailViewModel: ContentDetailViewModel = {
        let contentDetailViewModel = ContentDetailViewModel(
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
    init(contentType: ContentType, contentID: Int, router: ContentDetailRouter, networkService: NetworkServiceProtocol) {
        self.contentType = contentType
        self.contentID = contentID
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: ContentDetailViewProtocol) {
        self.ui = ui
        loadData()
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
            router.showOtherContentDetailViewController(for: contentType.firstAdditionalContent, with: selectedContentID, networkService: networkService)
        case .secondContent:
            guard indexPath.item < contentDetailViewModel.secondContent.count else { return }
            selectedContentID = contentDetailViewModel.secondContent[indexPath.item].id
            router.showOtherContentDetailViewController(for: contentType.secondAdditionalContent, with: selectedContentID, networkService: networkService)
        }
    }
}

// MARK: - Private Extension
private extension ContentDetailPresenter {
    func loadData() {
        let dispatchGroup = DispatchGroup()
        
        ui?.startLoadingAnimation()
        
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
}

// MARK: Extension Network Fetches
private extension ContentDetailPresenter {
    func getDescriptionContent<T: Decodable>(from endpoint: Endpoint, dispatchGroup: DispatchGroup, mapResult: @escaping (T) -> Descriptable) {
        dispatchGroup.enter()
        networkService.fetch(from: endpoint) { [weak self] (result: Result<BaseResponseDTO<T>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure(let error):
                    print("getDescriptionContent<T: Decodable> with ID Bad", error.localizedDescription)
                case .success(let baseResponseDTO):
                    guard let content = baseResponseDTO.data.results.map({ mapResult($0) }).first
                    else { return }
                    
                    self?.contentDetailViewModel.description = .init(id: content.id, title: content.title, decription: content.description)
                    
                    self?.fetchAndSetImage(from: content.thumbnailURL, index: 0, arrayType: .description, dispatchGroup: dispatchGroup)
                }
            }
        }
    }
    
    private func getAdditionalContent<T: Decodable>(for arrayType: ArrayType, from endpoint: Endpoint, dispatchGroup: DispatchGroup, mapResult: @escaping (T) -> Descriptable) {
        dispatchGroup.enter()
        networkService.fetch(from: endpoint) { [weak self] (result: Result<BaseResponseDTO<T>, Error>) in
            DispatchQueue.main.async {
                defer { dispatchGroup.leave() }
                switch result {
                case .failure(let error):
                    print("getAdditionalContent<T: Decodable> Bad", error.localizedDescription)
                case .success(let baseResponseDTO):
                    let contents = baseResponseDTO.data.results.map { mapResult($0) }
                    
                    switch arrayType {
                        
                    case .description:
                        break
                    case .firstContent:
                        self?.contentDetailViewModel.firstContent = contents.map { .init(id: $0.id, title: $0.title) }
                    case .secondContent:
                        self?.contentDetailViewModel.secondContent = contents.map { .init(id: $0.id, title: $0.title) }
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
                case .failure(let error):
                    print("fetchAndSetImage Bad", error.localizedDescription)
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
