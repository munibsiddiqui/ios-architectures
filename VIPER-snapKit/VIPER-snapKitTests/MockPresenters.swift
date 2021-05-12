//
//  MockPresenters.swift
//  VIPER-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/12.
//

import Foundation
import UIKit
import Moya

@testable import VIPER_snapKit

class Mock {
    static let shared = Mock()
    
    private let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<BeerAPI>(stubClosure: { _ in .immediate }))
    
    func getBeerListPresenter() -> BeerListPresenter {
        let interactor = BeerListInteractor(networkingApi: mockNetworkingAPI)
        let router = BeerListRouter(navigationController: UINavigationController(), networkingApi: mockNetworkingAPI)
        return BeerListPresenter(interactor: interactor, router: router)
    }
    
    func getSearchBeerPresenter() -> SearchBeerPresenter {
        let interactor = SearchBeerInteractor(networkingApi: mockNetworkingAPI)
        let router = SearchBeerRouter(navigationController: UINavigationController(), networkingApi: mockNetworkingAPI)
        return SearchBeerPresenter(interactor: interactor, router: router)
    }
    
    func getRandomBeerPresenter() -> RandomBeerPresenter {
        let interactor = RandomBeerInteractor(networkingApi: mockNetworkingAPI)
        let router = RandomBeerRouter(navigationController: UINavigationController(), networkingApi: mockNetworkingAPI)
        return RandomBeerPresenter(interactor: interactor, router: router)
    }
}
