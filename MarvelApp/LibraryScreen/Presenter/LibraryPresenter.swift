//
//  LibraryPresenter.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

final class LibraryPresenter {
    // MARK: - Private Properties
    private let router: LibraryRouter
    private let coreDataService: CoreDataServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var dataSource: LibraryCollectionViewDataSource?
    private var libraryViewModel = LibraryViewModel(comics: [], characters: [], series: [], events: [], creators: [])
    private weak var ui: LibraryViewProtocol?
    
    // MARK: - Initialization
    init(router: LibraryRouter, coreDataService: CoreDataServiceProtocol, networkService: NetworkServiceProtocol) {
        self.coreDataService = coreDataService
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: LibraryViewProtocol) {
        self.ui = ui
        loadData()
    }
    
    func uiWillAppear(animated: Bool) {
        ui?.setNavigationBarHidden(true, animated: animated)
        guard coreDataService.hasChanges else { return }
        loadData()
    }
    
    func uiWillDisappear(animated: Bool) {
        ui?.setNavigationBarHidden(false, animated: animated)
    }
    
    func didSelectSegment(_ index: Int) {
        ui?.scrollToCollectionViewSection(index, animated: true)
    }
    
    func scrollViewDidEndDecelerating(at index: Int) {
        ui?.selectSegmentedControlIndex(index)
    }
    
    func didTapContent(at indexPath: IndexPath) {
        guard indexPath.section < ContentType.allCases.count else { return }
        
        let section = ContentType.allCases[indexPath.section]
        let selectedContentID: Int
        let selectedContentType: ContentType
        
        switch section {
        case .comic:
            guard indexPath.item < libraryViewModel.comics.count else { return }
            selectedContentID = libraryViewModel.comics[indexPath.item].id
            selectedContentType = .comic
        case .character:
            guard indexPath.item < libraryViewModel.characters.count else { return }
            selectedContentID = libraryViewModel.characters[indexPath.item].id
            selectedContentType = .character
        case .series:
            guard indexPath.item < libraryViewModel.series.count else { return }
            selectedContentID = libraryViewModel.series[indexPath.item].id
            selectedContentType = .series
        case .event:
            guard indexPath.item < libraryViewModel.events.count else { return }
            selectedContentID = libraryViewModel.events[indexPath.item].id
            selectedContentType = .event
        case .creator:
            guard indexPath.item < libraryViewModel.creators.count else { return }
            selectedContentID = libraryViewModel.creators[indexPath.item].id
            selectedContentType = .creator
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
private extension LibraryPresenter {
    func loadData() {
        ui?.startLoadingAnimation()
        fetchContents()
    }
    
    func fetchContents() {
        let dispatchGroup = DispatchGroup()
        
        ContentType.allCases.forEach { fetch(for: $0, dispatchGroup: dispatchGroup) }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.setupUIDataSource()
            self?.ui?.stopLoadingAnimation()
        }
    }
    
    func fetch(for content: ContentType, dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        switch content {
        case .comic:
            self.coreDataService.fetchAllComics { [weak self] result in
                self?.setupViewModel(result, for: content, dispatchGroup: dispatchGroup)
            }
        case .character:
            self.coreDataService.fetchAllCharacters { [weak self] result in
                self?.setupViewModel(result, for: content, dispatchGroup: dispatchGroup)
            }
        case .series:
            self.coreDataService.fetchAllSeries { [weak self] result in
                self?.setupViewModel(result, for: content, dispatchGroup: dispatchGroup)
            }
        case .event:
            self.coreDataService.fetchAllEvents { [weak self] result in
                self?.setupViewModel(result, for: content, dispatchGroup: dispatchGroup)
            }
        case .creator:
            self.coreDataService.fetchAllCreators { [weak self] result in
                self?.setupViewModel(result, for: content, dispatchGroup: dispatchGroup)
            }
        }
    }
    
    func setupUIDataSource() {
        dataSource = LibraryCollectionViewDataSource(libraryViewModel)
        ui?.setupDataSource(with: dataSource)
    }
    
    func setupViewModel<T: DescriptableProtocol>(
        _ result: Result<[T], Error>,
        for content: ContentType,
        dispatchGroup: DispatchGroup
    ) {
        DispatchQueue.main.async {
            defer { dispatchGroup.leave() }
            switch result {
            case .failure:
                break
            case .success(let contents):
                switch content {
                case .comic:
                    self.libraryViewModel.comics = contents
                case .character:
                    self.libraryViewModel.characters = contents
                case .series:
                    self.libraryViewModel.series = contents
                case .event:
                    self.libraryViewModel.events = contents
                case .creator:
                    self.libraryViewModel.creators = contents
                }
            }
        }
    }
}
