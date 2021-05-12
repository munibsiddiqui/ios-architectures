//
//  RandomBeerRepository.swift
//  MVVM-RxSwift-coreData
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import RxSwift

class DefaultRandomBeerRepository: RandomBeerRepository {
    let coreDataManager = CoreDataManager()
    
    func randomBeer() -> Single<[Beer]> {
        return Single<[Beer]>.create { single in
            let response = URLSession.shared.rx.response(request: BeerAPI.setRequest(.random))
            
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
            }, onError: { error in
                self.coreDataManager.localRandom() { result in
                    switch result {
                    case let .success(beers):
                        return single(.success(beers))
                    case let .failure(error):
                        return single(.error(error))
                    }
                }
                return single(.error(NetworkingError.defaultError))
            })
        }
    }
}
