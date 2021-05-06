//
//  SearchBeerCoordinator.swift
//  MVVM-C-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/04.
//

import Foundation
import UIKit

class SearchBeerCoordinator: BaseCoordinator {
    var delegate: dismissBarProtocol?
    
    override func start() {
        let vc = SearchBeerVC(coordinator: self)
        vc.tabBarItem = UITabBarItem(title: "Search ID", image: UIImage(systemName: "2.circle"), tag: 1)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
