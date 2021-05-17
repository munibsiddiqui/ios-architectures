//
//  MockAppDI.swift
//  SwiftUI-CleanTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Moya

@testable import SwiftUI_Clean

class MockAppDI {
    static let shared = MockAppDI()
    
    func successBeerListViewModel() -> BeerListViewModel {
        let repository = SuccessBeerListRepository()
        let useCase = DefaultBeerListUseCase(beerListRepository: repository)
        return  BeerListViewModel(beerListUseCase: useCase)
    }
    
    func successSearchBeerViewModel() -> SearchBeerViewModel {
        let repository = SuccessSearchBeerRepository()
        let useCase = DefaultSearchBeerUseCase(searchBeerRepository: repository)
        return SearchBeerViewModel(searchBeerUseCase: useCase)
    }

    func successRandomBeerViewModel() -> RandomBeerViewModel {
        let repository = SuccessRandomBeerRepository()
        let useCase = DefaultRandomBeerUseCase(randomBeerRepository: repository)
        return RandomBeerViewModel(randomBeerUseCase: useCase)
    }
    
    func failBeerListViewModel() -> BeerListViewModel {
        let repository = FailBeerListRepository()
        let useCase = DefaultBeerListUseCase(beerListRepository: repository)
        return  BeerListViewModel(beerListUseCase: useCase)
    }
    
    func failSearchBeerViewModel() -> SearchBeerViewModel {
        let repository = FailSearchBeerRepository()
        let useCase = DefaultSearchBeerUseCase(searchBeerRepository: repository)
        return SearchBeerViewModel(searchBeerUseCase: useCase)
    }

    func failRandomBeerViewModel() -> RandomBeerViewModel {
        let repository = FailRandomBeerRepository()
        let useCase = DefaultRandomBeerUseCase(randomBeerRepository: repository)
        return RandomBeerViewModel(randomBeerUseCase: useCase)
    }
    
}
