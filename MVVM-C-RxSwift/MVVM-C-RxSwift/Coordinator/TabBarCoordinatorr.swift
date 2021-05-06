//
//  TabBarCoordinatorr.swift
//  MVVM-C-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/04.
//

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    override func start() {
        let vc = TabBarController(coordinator: self)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: false)
    }
    
}
