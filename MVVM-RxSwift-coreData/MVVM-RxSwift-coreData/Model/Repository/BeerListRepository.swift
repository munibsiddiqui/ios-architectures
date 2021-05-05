//
//  BeerRepository.swift
//  MVVM-RxSwift-coreData
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import RxSwift
import Moya
import CoreData

protocol BeerListRepository {
    func getBeerList(page: Int) -> Single<[Beer]>
}

class DefaultBeerListRepository: BeerListRepository {
    let coreDataManager = CoreDataManager()
    
    func getBeerList(page: Int) -> Single<[Beer]> {
        return Single<[Beer]>.create { single in
            let response = URLSession.shared.rx.response(request: self.setRequest(.getBeerList(page: page)))
            
            return response.subscribe(onNext: { response, data in
                if 200..<300 ~= response.statusCode {
                    guard let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                        return single(.error(MoyaError.encodableMapping(Error.self as! Error)))
                    }
                    for beer in beers {
                        self.coreDataManager.save(for: beer)
                    }
                    return single(.success(beers))
                }
            }, onError: { error in
                self.getLocalBeerList(page: page) { result in
                    switch result {
                    case let .success(beers):
                        return single(.success(beers))
                    case let .failure(error):
                        return single(.error(error))
                    }
                }
                return single(.error(MoyaError.encodableMapping(error)))
            })
        }
    }
    
    func getLocalBeerList(page: Int,
                         completion: @escaping ((Result<[Beer], Error>) -> Void)) {
        var beers = [Beer]()
        for i in (page - 1) * 25 ... page * 25  {
            let predicate = NSPredicate(format: "id = %d", i)
            if let beerEntity = coreDataManager.persistentContainer.viewContext.fetchData(entity: BeerEntity.self, predicate: predicate) as? [BeerEntity] {
                for beer in beerEntity {
                    beers.append(beer.toDTO())
                }
            } else { }
        }
        completion(.success(beers))
    }
}

extension DefaultBeerListRepository {
    private func setRequest(_ api: BeerAPI) -> URLRequest {
        var url = api.baseURL + api.path
        if api.querys != nil {
            url += "?"
            for query in api.querys! {
                url += query.key + "=" + query.value
            }
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = api.method
        return request
    }
}
