//
//  BeerListRepository.swift
//  Clean-MVVM
//
//  Created by GoEun Jeong on 2021/05/10.
//

import Foundation
import RxSwift

protocol BeerListRepository {
    func getBeerList(page: Int) -> Single<[Beer]>
}
