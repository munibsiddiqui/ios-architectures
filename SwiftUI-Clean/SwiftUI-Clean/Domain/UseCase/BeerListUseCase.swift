//
//  BeerListUseCase.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol BeerListUseCase {
    func execute(page: Int) -> AnyPublisher<[Beer], NetworkingError>
}

final class DefaultBeerListUseCase: BeerListUseCase {
    private let beerListRepository: BeerListRepository
    
    init(beerListRepository: BeerListRepository) {
        self.beerListRepository = beerListRepository
    }
    
    func execute(page: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return beerListRepository.getBeerList(page: page)
    }
}
