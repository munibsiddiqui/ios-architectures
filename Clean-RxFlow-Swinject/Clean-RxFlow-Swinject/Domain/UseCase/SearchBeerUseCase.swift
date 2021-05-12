//
//  SearchBeerUseCase.swift
//  Clean-MVVM
//
//  Created by GoEun Jeong on 2021/05/10.
//

import Foundation
import RxSwift

protocol SearchBeerUseCase {
    func execute(id: Int) -> Single<[Beer]>
}

final class DefaultSearchBeerUseCase: SearchBeerUseCase {
    private let searchBeerRepository: SearchBeerRepository
    
    init(searchBeerRepository: SearchBeerRepository) {
        self.searchBeerRepository = searchBeerRepository
    }
    
    func execute(id: Int) -> Single<[Beer]> {
        return searchBeerRepository.searchID(id: id)
    }
}

