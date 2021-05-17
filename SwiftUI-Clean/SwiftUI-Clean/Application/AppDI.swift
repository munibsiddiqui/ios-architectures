//
//  AppDI.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation

class AppDI {
    static let shared = AppDI()
    
    func getBeerListView() -> BeerListView {
        let repository = DefaultBeerListRepository()
        let useCase = DefaultBeerListUseCase(beerListRepository: repository)
        let viewModel = BeerListViewModel(beerListUseCase: useCase)
        return BeerListView(viewModel: viewModel)
    }
    
    func getSearchBeerView() -> SearchBeerView {
        let repository = DefaultSearchBeerRepository()
        let useCase = DefaultSearchBeerUseCase(searchBeerRepository: repository)
        let viewModel = SearchBeerViewModel(searchBeerUseCase: useCase)
        return SearchBeerView(viewModel: viewModel)
    }

    func getRandomBeerView() -> RandomBeerView {
        let repository = DefaultRandomBeerRepository()
        let useCase = DefaultRandomBeerUseCase(randomBeerRepository: repository)
        let viewModel = RandomBeerViewModel(randomBeerUseCase: useCase)
        return RandomBeerView(viewModel: viewModel)
    }
    
}
