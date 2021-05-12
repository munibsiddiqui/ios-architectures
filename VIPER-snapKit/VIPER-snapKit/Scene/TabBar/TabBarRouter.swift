//
//  TabBarRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit

enum TabbarChildRouter: Int {
    case beerList
    case searchBeer
    case randomBeer
}

final class TabbarRouter: NavigationRouterType {
    let navigationController: UINavigationController
    private let networkingApi: NetworkingService
    private var tabbarController = UITabBarController()
    private var childRouters: [TabbarChildRouter: NavigationRouterType]
    
    init(
        navigationController: UINavigationController,
        networkingApi: NetworkingService
    ) {
        self.navigationController = navigationController
        self.networkingApi = networkingApi
        self.childRouters = [:]
    }
}

extension TabbarRouter {
    func start() {
        setupBeerListRouter()
        setupSearchBeerRouter()
        setupRandomBeerRouter()
        
        setupTabbarController()
    }
    
    private func store(with router: NavigationRouterType, as type: TabbarChildRouter) {
        childRouters[type] = router
    }
}

extension TabbarRouter {
    private func setupBeerListRouter() {
        let listNavigationController = configureNavigationControllerWithTabs(
            title: "Beer List",
            image: UIImage(systemName: "1.circle")
        )
        let router = BeerListRouter(navigationController: listNavigationController, networkingApi: networkingApi)
        
        router.start()
        store(with: router, as: .beerList)
    }
    
    private func setupSearchBeerRouter() {
        let searchNavigationController = configureNavigationControllerWithTabs(
            title: "Search ID",
            image: UIImage(systemName: "2.circle")
        )
        let router = SearchBeerRouter(navigationController: searchNavigationController, networkingApi: networkingApi)
        router.start()
        
        store(with: router, as: .searchBeer)
    }
    
    private func setupRandomBeerRouter() {
        let randomNavigationController = configureNavigationControllerWithTabs(
            title: "Random",
            image: UIImage(systemName: "3.circle")
        )
        let router = RandomBeerRouter(navigationController: randomNavigationController, networkingApi: networkingApi)
        router.start()
        
        store(with: router, as: .randomBeer)
    }
}

extension TabbarRouter {
    private func setupTabbarController() {
        let tabbarController: UITabBarController = {
            $0.viewControllers = childRouters
                .sorted(by: { $0.0.rawValue < $1.0.rawValue })
                .map { $0.value.navigationController }
            return $0
        }(UITabBarController())
        self.tabbarController = tabbarController
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.setViewControllers([self.tabbarController], animated: false)
    }
}

extension TabbarRouter {
    private func configureNavigationControllerWithTabs(title: String, image: UIImage?) -> UINavigationController {
        let navigationController: UINavigationController = {
            $0.tabBarItem.title = title
            $0.tabBarItem.image = image
            return $0
        }(UINavigationController())
        return navigationController
    }
}
