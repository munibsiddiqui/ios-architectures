//
//  RealmManager.swift
//  MVVM-RxSwift-realm
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import RealmSwift

protocol LocalManager {
    func saveBeer(beer: Beer)
    func getLocalBeerList(page: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
    func searchLocalID(id: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
    func localRandom(completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
}

class RealmManager: LocalManager {
    
    func saveBeer(beer: Beer) {
        let realm = try! Realm()
        
        deleteBeer(beer: beer)
        
        let beerRealm = BeerRealm(beer: beer)
        do {
            try realm.write {
                realm.add(beerRealm)
            }
        } catch { print(error) }
    }
    
    func getLocalBeerList(page: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        let realm = try! Realm()
        
        let result = realm.objects(BeerRealm.self).filter("id >= \((page - 1) * 25 + 1) AND id <= \(page * 25)")
        var beerArray = [Beer]()
        for beer in result {
            beerArray.append(beer.toDTO())
        }
        
        if !beerArray.isEmpty {
            completion(.success(beerArray))
        } else {
            completion(.failure(NetworkingError.defaultError))
        }
    }
    
    func searchLocalID(id: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        let realm = try! Realm()
        
        let result = realm.objects(BeerRealm.self).filter("id = \(id)")
        var beerArray = [Beer]()
        for beer in result {
            beerArray.append(beer.toDTO())
        }
        if !beerArray.isEmpty {
            completion(.success(beerArray))
        } else {
            completion(.failure(NetworkingError.defaultError))
        }
    }
    
    func localRandom(completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        let realm = try! Realm()
        
        let result = realm.objects(BeerRealm.self).randomElement()
        var beerArray = [Beer]()
        beerArray.append(result?.toDTO() ?? Beer(id: nil, name: "Don't have data", description: nil, imageURL: nil))
        if !beerArray.isEmpty {
            completion(.success(beerArray))
        } else {
            completion(.failure(NetworkingError.defaultError))
        }
    }
    
    private func deleteBeer(beer: Beer) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(realm.objects(BeerRealm.self).filter("id = \(beer.id ?? 0)"))
            }
        } catch { print(error) }
    }
    
}
