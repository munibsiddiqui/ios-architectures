//
//  SearchBeerRepository.swift
//  SwiftUI-Clean
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Foundation
import Combine
import Moya

protocol SearchBeerRepository {
    func searchID(id: Int) -> AnyPublisher<[Beer], NetworkingError>
}

