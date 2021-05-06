//
//  BeerListCoordinator.swift
//  MVVM-C-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/04.
//

import UIKit

class BeerListCoordinator: BaseCoordinator {
    var delegate: dismissBarProtocol?
    
    override func start() {
        let vc = BeerListVC(coordinator: self)
        vc.tabBarItem = UITabBarItem(title: "Beer List", image: UIImage(systemName: "1.circle"), tag: 0)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    override func didFinish(coordinator: Coordinator) {
        super.didFinish(coordinator: coordinator)
        delegate?.dismissBar(false)
    }
    
    func goDetail(beer: Beer) {
        let vc = DetailBeerVC(coordinator: self, beer: beer)
        self.navigationController.pushViewController(vc, animated: true)
        delegate?.dismissBar(true)
    }
}
