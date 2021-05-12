//
//  RandomBeerUseCase.swift
//  Clean-MVVM
//
//  Created by GoEun Jeong on 2021/05/10.
//

import Foundation
import RxSwift

protocol RandomBeerUseCase {
    func execute() -> Single<[Beer]>
}

final class DefaultRandomBeerUseCase: RandomBeerUseCase {
    private let randomBeerRepository: RandomBeerRepository
    
    init(randomBeerRepository: RandomBeerRepository) {
        self.randomBeerRepository = randomBeerRepository
    }
    
    func execute() -> Single<[Beer]> {
        return randomBeerRepository.randomBeer()
    }
}

