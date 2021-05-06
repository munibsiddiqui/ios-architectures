//
//  BeerRepository.swift
//  MVVM-RxSwift-coreData
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import RxSwift
import CoreData

protocol BeerListRepository {
    func getBeerList(page: Int) -> Single<[Beer]>
}

class DefaultBeerListRepository: BeerListRepository {
    let coreDataManager = CoreDataManager()
    
    func getBeerList(page: Int) -> Single<[Beer]> {
        return Single<[Beer]>.create { single in
            let response = URLSession.shared.rx.response(request: BeerAPI.setRequest(.getBeerList(page: page)))
            
            return response.subscribe(onNext: { response, data in
                if 200..<300 ~= response.statusCode {
                    guard let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                        return single(.error(NetworkingError.error("JSON 파싱 에러")))
                    }
                    for beer in beers {
                        self.coreDataManager.saveBeer(beer: beer)
                    }
                    return single(.success(beers))
                }
            }, onError: { _ in
                self.coreDataManager.getLocalBeerList(page: page) { result in
                    switch result {
                    case let .success(beers):
                        return single(.success(beers))
                    case let .failure(error):
                        return single(.error(error))
                    }
                }
            })
        }
    }
}
