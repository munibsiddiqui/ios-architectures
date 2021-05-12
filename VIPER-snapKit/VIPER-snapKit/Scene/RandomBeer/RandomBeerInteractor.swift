//
//  RandomBeerInteractor.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import RxSwift

class RandomBeerInteractor: RandomBeerInteractorProtocol {
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService) {
        self.networkingApi = networkingApi
    }
    
    func fetchRandomBeerfromAPI() -> Single<[Beer]> {
        networkingApi.request(.random)
    }
}
