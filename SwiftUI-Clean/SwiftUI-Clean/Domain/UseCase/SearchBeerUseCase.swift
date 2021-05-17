//
//  SearchBeerUseCase.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol SearchBeerUseCase {
    func execute(id: Int) -> AnyPublisher<[Beer], NetworkingError>
}

final class DefaultSearchBeerUseCase: SearchBeerUseCase {
    private let searchBeerRepository: SearchBeerRepository
    
    init(searchBeerRepository: SearchBeerRepository) {
        self.searchBeerRepository = searchBeerRepository
    }
    
    func execute(id: Int) -> AnyPublisher<[Beer], NetworkingError> {
        return searchBeerRepository.searchID(id: id)
    }
}

