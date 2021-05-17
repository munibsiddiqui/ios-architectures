//
//  NetworkingService.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import Moya
import RxSwift

protocol NetworkingService {
    func request(_ api: BeerAPI) -> Single<[Beer]>
}

final class NetworkingAPI: NetworkingService {
    let provider: MoyaProvider<BeerAPI>
    
    init(provider: MoyaProvider<BeerAPI> = MoyaProvider<BeerAPI>()) {
        self.provider = provider
    }
    
    func request(_ api: BeerAPI) -> Single<[Beer]> {
        return provider.rx.request(api)
            .filterSuccessfulStatusCodes()
            .map([Beer].self)
    }
}
