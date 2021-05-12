//
//  SearchBeerInteractor.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import RxSwift

class SearchBeerInteractor: SearchBeerInteractorProtocol {
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService) {
        self.networkingApi = networkingApi
    }
    
    func fetchSearchBeerfromAPI(id: Int) -> Single<[Beer]> {
        networkingApi.request(.searchID(id: id))
    }
}
