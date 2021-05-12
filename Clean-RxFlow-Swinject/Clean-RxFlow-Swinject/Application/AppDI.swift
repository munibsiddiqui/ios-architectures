//
//  File.swift
//  Clean-MVVM
//
//  Created by GoEun Jeong on 2021/05/10.
//

import Foundation

class AppDI {
    static let shared = AppDI()
    
    func getBeerListVC() -> BeerListVC {
        let repository = DefaultBeerListRepository()
        let useCase = DefaultBeerListUseCase(beerListRepository: repository)
        let viewModel = BeerListViewModel(beerListUseCase: useCase)
        return BeerListVC(viewModel: viewModel)
    }
    
    func getSearchBeerVC() -> SearchBeerVC {
        let repository = DefaultSearchBeerRepository()
        let useCase = DefaultSearchBeerUseCase(searchBeerRepository: repository)
        let viewModel = SearchBeerViewModel(searchBeerUseCase: useCase)
        return SearchBeerVC(viewModel: viewModel)
    }

    func getRandomBeerVC() -> RandomBeerVC {
        let repository = DefaultRandomBeerRepository()
        let useCase = DefaultRandomBeerUseCase(randomBeerRepository: repository)
        let viewModel = RandomBeerViewModel(randomBeerUseCase: useCase)
        return RandomBeerVC(viewModel: viewModel)
    }
    
}
