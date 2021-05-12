//
//  RandomBeerRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import UIKit

class RandomBeerRouter: RandomBeerRouterProtocol, NavigationRouterType {
    let navigationController: UINavigationController
    let networkingApi: NetworkingService
    
    init(navigationController: UINavigationController,
         networkingApi: NetworkingService) {
        self.navigationController = navigationController
        self.networkingApi = networkingApi
    }
    
    func start() {
        showRandomBeer()
    }
    
    private func showRandomBeer() {
        let interactor = RandomBeerInteractor(networkingApi: networkingApi)
        let presenter = RandomBeerPresenter(interactor: interactor, router: self)
        
        let viewController = RandomBeerViewController(presenter: presenter)
        navigationController.show(viewController, sender: nil)
    }
    
    func showAlert(string: String) {
        navigationController.showErrorAlert(with: string)
    }
}
