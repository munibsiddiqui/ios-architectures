//
//  TabBarVC.swift
//  MVC-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import UIKit

protocol dismissBarProtocol {
    func dismissBar(_ value: Bool)
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private let coordinator: TabBarCoordinator
    @Inject var beerListCoordinator: BeerListCoordinator
    @Inject var searchBeerCoordinator: SearchBeerCoordinator
    @Inject var randomBeerCoordinator: RandomBeerCoordinator
    
    init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        beerListCoordinator.delegate = self
        searchBeerCoordinator.delegate = self
        randomBeerCoordinator.delegate = self
        
        beerListCoordinator.start()
        searchBeerCoordinator.start()
        randomBeerCoordinator.start()
        
        self.viewControllers = [beerListCoordinator.navigationController, searchBeerCoordinator.navigationController, randomBeerCoordinator.navigationController]
    }
    
}

extension TabBarController: dismissBarProtocol {
    func dismissBar(_ value: Bool) {
        self.tabBar.isHidden = value
    }
}
