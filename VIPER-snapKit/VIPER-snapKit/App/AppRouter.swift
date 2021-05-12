//
//  AppRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit

enum AppBaseRouterType {
    case tabbar
}

final class AppRouter {
    let navigationController: UINavigationController
    let networkingApi: NetworkingService
    
    init(
        networkingApi: NetworkingService,
        navigationController: UINavigationController
    ) {
        self.networkingApi = networkingApi
        self.navigationController = navigationController
    }
    
    func start() {
        showTabbar()
    }
}

extension AppRouter {
    private func showTabbar() {
        let tabbarRouter = TabbarRouter(navigationController: navigationController, networkingApi: networkingApi)
        tabbarRouter.start()
    }
}
