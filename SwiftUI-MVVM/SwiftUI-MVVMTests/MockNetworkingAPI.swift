//
//  MockNetworkingPAI.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/30.
//

import Foundation
@testable import SwiftUI_MVVM

class MockNetworkingAPI: NetworkingService {
    
    func getBeerFromJson(_ api: BeerAPI) -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch api {
        case .getBeerList:
            return bundle!.decode([Beer].self, from: "BeerList.json")
        default:
            return bundle!.decode([Beer].self, from: "SingleBeer.json")
        }
    }
    
    func request(_ api: BeerAPI, completion: @escaping (Result<[Beer], Error>) -> Void) {
        completion(.success((getBeerFromJson(api))))
    }
}

class FailedNetworkingAPI: NetworkingService {
    func request(_ api: BeerAPI, completion: @escaping (Result<[Beer], Error>) -> Void) {
        completion(.failure(FailedError.noInternet))
    }
}

enum FailedError: Error {
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "No Internet"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .noInternet:
            return "The operation couldn’t be completed. (SwiftUI_MVVMTests.FailedError error 0.)"
        }
    }
}
