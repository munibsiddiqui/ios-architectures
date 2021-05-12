//
//  Container+RegisterDependencies.swift
//  Clean-RxFlow-Swinject
//
//  Created by GoEun Jeong on 2021/05/11.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerDependencies() {
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerViewControllers()
    }
    
    func registerRepositories() {
        autoregister(BeerListRepository.self, initializer: DefaultBeerListRepository.init)
        autoregister(RandomBeerRepository.self, initializer: DefaultRandomBeerRepository.init)
        autoregister(SearchBeerRepository.self, initializer: DefaultSearchBeerRepository.init)
    }
    
    func registerUseCases() {
        autoregister(BeerListUseCase.self, initializer: DefaultBeerListUseCase.init)
        autoregister(RandomBeerUseCase.self, initializer: DefaultRandomBeerUseCase.init)
        autoregister(SearchBeerUseCase.self, initializer: DefaultSearchBeerUseCase.init)
    }
    
    func registerViewModels() {
        autoregister(BeerListViewModel.self, initializer: BeerListViewModel.init)
        autoregister(RandomBeerViewModel.self, initializer: RandomBeerViewModel.init)
        autoregister(SearchBeerViewModel.self, initializer: SearchBeerViewModel.init)
    }
    
    func registerViewControllers() {
        autoregister(BeerListVC.self, initializer: BeerListVC.init)
        autoregister(RandomBeerVC.self, initializer: RandomBeerVC.init)
        autoregister(SearchBeerVC.self, initializer: SearchBeerVC.init)
    }
}
