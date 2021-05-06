//
//  AppCoordinator.swift
//  MVVM-C-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/04.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    private let window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        window.makeKeyAndVisible()
        tabBar()
    }
    
    private func tabBar() {
        removeChildCoordinators()
        
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        start(coordinator: coordinator)
        
        window.rootViewController = coordinator.navigationController
    }
    
}
