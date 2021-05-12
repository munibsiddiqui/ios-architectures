//
//  SearchBeerRouter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import UIKit

class SearchBeerRouter: SearchBeerRouterProtocol, NavigationRouterType {
    let navigationController: UINavigationController
    let networkingApi: NetworkingService
    
    init(navigationController: UINavigationController,
         networkingApi: NetworkingService) {
        self.navigationController = navigationController
        self.networkingApi = networkingApi
    }
    
    func start() {
        showSearchBeer()
    }
    
    func showSearchBeer() {
        let interactor = SearchBeerInteractor(networkingApi: networkingApi)
        let presenter = SearchBeerPresenter(interactor: interactor, router: self)
        
        let viewController = SearchBeerViewController(presenter: presenter)
        navigationController.show(viewController, sender: nil)
    }
    
    func showAlert(string: String) {
        navigationController.showErrorAlert(with: string)
    }
}
