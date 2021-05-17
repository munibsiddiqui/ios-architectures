//
//  RandomBeerUseCase.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol RandomBeerUseCase {
    func execute() -> AnyPublisher<[Beer], NetworkingError>
}

final class DefaultRandomBeerUseCase: RandomBeerUseCase {
    private let randomBeerRepository: RandomBeerRepository
    let coreDataManager = CoreDataManager()
    
    init(randomBeerRepository: RandomBeerRepository) {
        self.randomBeerRepository = randomBeerRepository
    }
    
    func execute() -> AnyPublisher<[Beer], NetworkingError> {
        return randomBeerRepository.randomBeer()
    }
}

