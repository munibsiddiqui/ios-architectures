//
//  BeerListInteractor.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import RxSwift

class BeerListInteractor: BeerListInteractorProtocol {
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService) {
        self.networkingApi = networkingApi
    }
    
    func fetchBeerListfromAPI(page: Int) -> Single<[Beer]> {
        networkingApi.request(.getBeerList(page: page))
    }
}
