//
//  MockNetworkingPAI.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/30.
//

import Foundation
import RxSwift

@testable import ReactorKit_RxFlow

extension Bundle {
    static func getBeerFromJson(_ api: BeerAPI) -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch api {
        case .getBeerList:
            return bundle!.decode([Beer].self, from: "BeerList.json")
        case .getDetailBeer:
            break
        case.random:
            return bundle!.decode([Beer].self, from: "RandomBeer.json")
        case .searchID:
            return bundle!.decode([Beer].self, from: "SingleBeer.json")
        }
        return [Beer]()
    }
}

class MockNetworkingAPI: NetworkingService {
    
    func request(_ api: BeerAPI) -> Single<[Beer]> {
        return Single.just(Bundle.getBeerFromJson(api))
    }
}


