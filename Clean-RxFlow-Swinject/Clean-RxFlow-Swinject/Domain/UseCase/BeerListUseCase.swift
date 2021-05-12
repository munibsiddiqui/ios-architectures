//
//  BeerListUseCase.swift
//  Clean-MVVM
//
//  Created by GoEun Jeong on 2021/05/10.
//

import Foundation
import RxSwift

protocol BeerListUseCase {
    func execute(page: Int) -> Single<[Beer]>
}

final class DefaultBeerListUseCase: BeerListUseCase {
    private let beerListRepository: BeerListRepository
    
    init(beerListRepository: BeerListRepository) {
        self.beerListRepository = beerListRepository
    }
    
    func execute(page: Int) -> Single<[Beer]> {
        return beerListRepository.getBeerList(page: page)
    }
}

