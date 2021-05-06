//
//  RandomBeerCoordinator.swift
//  MVVM-C-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/04.
//

import Foundation
import UIKit

class RandomBeerCoordinator: BaseCoordinator {
    var delegate: dismissBarProtocol?
    
    override func start() {
        let vc = RandomBeerVC(coordinator: self)
        vc.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "3.circle"), tag: 2)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
