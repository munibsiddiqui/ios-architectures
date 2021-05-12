//
//  BaseRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit

protocol NavigationRouterType {
    var navigationController: UINavigationController { get }
    
    func start()
}
