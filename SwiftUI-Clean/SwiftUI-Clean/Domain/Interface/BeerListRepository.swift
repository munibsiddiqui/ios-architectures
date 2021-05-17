//
//  BeerListRepository.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol BeerListRepository {
    func getBeerList(page: Int) -> AnyPublisher<[Beer], NetworkingError>
}
