//
//  RandomBeerRepository.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol RandomBeerRepository {
    func randomBeer() -> AnyPublisher<[Beer], NetworkingError>
}
