//
//  MockRepository.swift
//  MVVM-RxSwift-coreDataTests
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import RxSwift
@testable import MVVM_RxSwift_coreData

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

class MockBeerListRepository: BeerListRepository {
    func getBeerList(page: Int) -> Single<[Beer]> {
        return Single.just(Bundle.getBeerFromJson(.getBeerList(page: page)))
    }
}

class MockSearchBeerRepository: SearchBeerRepository {
    func searchID(id: Int) -> Single<[Beer]> {
        return Single.just(Bundle.getBeerFromJson(.searchID(id: id)))
    }
}

class MockRandomBeerRepository: RandomBeerRepository {
    func randomBeer() -> Single<[Beer]> {
        return Single.just(Bundle.getBeerFromJson(.random))
    }
}


