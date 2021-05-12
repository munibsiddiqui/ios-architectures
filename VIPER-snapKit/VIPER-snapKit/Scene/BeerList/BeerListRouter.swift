//
//  BeerListRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import UIKit

class BeerListRouter: NavigationRouterType, BeerListRouterProtocol {
    let navigationController: UINavigationController
    let networkingApi: NetworkingService
    
    init(
        navigationController: UINavigationController,
        networkingApi: NetworkingService
    ) {
        self.navigationController = navigationController
        self.networkingApi = networkingApi
    }
    
    func start() {
        showBeerList()
    }
    
    private func showBeerList() {
        let interactor = BeerListInteractor(networkingApi: networkingApi)
        let presenter = BeerListPresenter(interactor: interactor, router: self)
        
        let viewController = BeerListViewController(presenter: presenter)
        navigationController.show(viewController, sender: nil)
    }
    
    func showBeerDetail(beer: Beer) {
        let detailBeerVC = DetailBeerViewController(beer: beer)
        detailBeerVC.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(detailBeerVC, animated: true)
    }
    
    func showAlert(string: String) {
        navigationController.showErrorAlert(with: string)
    }
}
