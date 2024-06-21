//
//  OnboardingPageViewController.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
    // MARK: - Private Properties
    private let presenter: OnboardingPresenter
    private var pages = [UIViewController]()
    private var initialPage = 0
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = AppColor.onboardingCurrentPageIndicator
        pageControl.pageIndicatorTintColor = AppColor.onboardingPageIndicatorTintColor
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var startExploringButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Start Exploring"
        config.buttonSize = .large
        config.cornerStyle = .capsule
        config.baseBackgroundColor = AppColor.accentColor
        config.baseForegroundColor = AppColor.coverComicTextColor
        button.configuration = config
        button.addTarget(self, action: #selector(didTapStartExploringButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    init(presenter: OnboardingPresenter) {
        self.presenter = presenter
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(ui: self)
        setupUI()
    }
}

// MARK: - Extension OnboardingViewProtocol
extension OnboardingPageViewController: OnboardingViewProtocol {
    func setOnboardingViewControllers(with viewModels: [OnboardingViewModel], initialPage: Int) {
        self.initialPage = initialPage
        pages = viewModels.map { OnboardingViewController(with: $0.imageName, and: $0.labelText) }
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    func setDataSourceAndDelegate() {
        dataSource = self
        delegate = self
    }
    
    func setPageControlCurrentPage(with index: Int) {
        pageControl.currentPage = index
    }
}

// MARK: - Extension UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = pages.firstIndex(of: viewController), index > 0 {
            return pages[index - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let index = pages.firstIndex(of: viewController), index < pages.count - 1 {
            return pages[index + 1]
        } else {
            return nil
        }
    }
}

// MARK: - Extension UIPageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pages.firstIndex(of: viewControllers[0])
        else { return }
        
        presenter.didChangePage(index: currentIndex)
    }
}

// MARK: - Private Extension
private extension OnboardingPageViewController {
    func setupUI() {
        view.backgroundColor = AppColor.background
        view.addSubview(pageControl)
        view.addSubview(startExploringButton)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            startExploringButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(
                equalToSystemSpacingBelow: startExploringButton.bottomAnchor,
                multiplier: 1.0
            ),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalToSystemSpacingBelow: pageControl.bottomAnchor,
                multiplier: 1.0
            )
        ])
    }
    
    @objc func didTapStartExploringButton() {
        presenter.didTapStartExploringButton()
    }
}
