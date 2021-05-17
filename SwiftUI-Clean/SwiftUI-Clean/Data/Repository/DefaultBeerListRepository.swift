//
//  DefaultBeerListRepository.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import CoreData
import Moya

class DefaultBeerListRepository: BeerListRepository {
    let coreDataManager = CoreDataManager()
    let provider: MoyaProvider<BeerAPI>
    
    init(provider: MoyaProvider<BeerAPI> = MoyaProvider<BeerAPI>()) {
        self.provider = provider
    }
    
    func getBeerList(page: Int) -> AnyPublisher<[Beer], NetworkingError> {
        self.provider.requestPublisher(.getBeerList(page: page))
            .filterSuccessfulStatusCodes()
            .map([Beer].self)
            .removeDuplicates()
            .mapError { NetworkingError.error($0.localizedDescription) }
            .tryCatch { _ in self.coreDataManager.localRandom() }
            .mapError { NetworkingError.error($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
