//
//  DefaultRandomBeerRepository.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import CoreData
import Moya

class DefaultRandomBeerRepository: RandomBeerRepository {
    let coreDataManager = CoreDataManager()
    let provider: MoyaProvider<BeerAPI>
    
    init(provider: MoyaProvider<BeerAPI> = MoyaProvider<BeerAPI>()) {
        self.provider = provider
    }
    
    func randomBeer() -> AnyPublisher<[Beer], NetworkingError> {
        self.provider.requestPublisher(.random)
            .filterSuccessfulStatusCodes()
            .map([Beer].self)
            .mapError { NetworkingError.error($0.localizedDescription) }
            .tryCatch { _ in self.coreDataManager.localRandom() }
            .mapError { NetworkingError.error($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
