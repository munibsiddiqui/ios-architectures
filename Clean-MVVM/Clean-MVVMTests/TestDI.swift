//
//  TestDI.swift
//  Clean-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/11.
//

import Foundation
@testable import Clean_MVVM

class TestDI {
    static let shared = TestDI()
    
    func getBeerListVM() -> BeerListViewModel {
        let repository = MockBeerListRepository()
        let useCase = DefaultBeerListUseCase(beerListRepository: repository)
        return BeerListViewModel(beerListUseCase: useCase)
    }
    
    func getSearchBeerVM() -> SearchBeerViewModel {
        let repository = MockSearchBeerRepository()
        let useCase = DefaultSearchBeerUseCase(searchBeerRepository: repository)
        return SearchBeerViewModel(searchBeerUseCase: useCase)
    }

    func getRandomBeerVM() -> RandomBeerViewModel {
        let repository = MockRandomBeerRepository()
        let useCase = DefaultRandomBeerUseCase(randomBeerRepository: repository)
        return RandomBeerViewModel(randomBeerUseCase: useCase)
    }
    
}
