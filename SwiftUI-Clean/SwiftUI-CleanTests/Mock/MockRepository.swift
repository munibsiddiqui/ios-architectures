//
//  MockRepository.swift
//  SwiftUI-CleanTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
@testable import SwiftUI_Clean

extension Bundle {
    static func getBeerFromJson(_ api: BeerAPI) -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch api {
        case .getBeerList:
            return bundle!.decode([Beer].self, from: "BeerList.json")
        case .getDetailBeer:
            break
        case .random, .searchID:
            return bundle!.decode([Beer].self, from: "SingleBeer.json")
        }
        return [Beer]()
    }
}

class SuccessBeerListRepository: BeerListRepository {
    func getBeerList(page: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return Just(Bundle.getBeerFromJson(.getBeerList(page: page)))
            .setFailureType(to: NetworkingError.self)
            .eraseToAnyPublisher()
    }
}

class SuccessSearchBeerRepository: SearchBeerRepository {
    func searchID(id: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return Just(Bundle.getBeerFromJson(.searchID(id: id)))
            .setFailureType(to: NetworkingError.self)
            .eraseToAnyPublisher()
    }
}

class SuccessRandomBeerRepository: RandomBeerRepository {
    func randomBeer() -> AnyPublisher<[Beer], NetworkingError> {
        return Just(Bundle.getBeerFromJson(.random))
            .setFailureType(to: NetworkingError.self)
            .eraseToAnyPublisher()
    }
}

class FailBeerListRepository: BeerListRepository {
    func getBeerList(page: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return Fail(error: NetworkingError.defaultError)
            .eraseToAnyPublisher()
    }
}

class FailSearchBeerRepository: SearchBeerRepository {
    func searchID(id: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return Fail(error: NetworkingError.defaultError)
            .eraseToAnyPublisher()
    }
}

class FailRandomBeerRepository: RandomBeerRepository {
    func randomBeer() -> AnyPublisher<[Beer], NetworkingError> {
        return Fail(error: NetworkingError.defaultError)
            .eraseToAnyPublisher()
    }
}
