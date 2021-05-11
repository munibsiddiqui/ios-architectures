//
//  RealmManagerTests.swift
//  MVVM-RxSwift-realmTests
//
//  Created by GoEun Jeong on 2021/05/11.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
import Nimble

@testable import MVVM_RxSwift_realm

class CoreDataManagerTests: XCTestCase {
    let realmManager = RealmManager()
    let jsonBeers = Bundle.getBeerFromJson(.getBeerList(page: 1))
    
    override func setUp() {
        for beer in jsonBeers {
            realmManager.saveBeer(beer: beer)
        }
    }
    
    func test_beerList_realm_save() {
        var realmDataBeers = [Beer]()
        
        realmManager.getLocalBeerList(page: 1) { result in
            switch result {
            case .success(let beers):
                realmDataBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers).to(equal(realmDataBeers))
    }
    
    func test_SearchBeer_realm_save() {
        var realmDataBeers = [Beer]()
        
        realmManager.searchLocalID(id: 3) { result in
            switch result {
            case .success(let beers):
                realmDataBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers[2]).to(equal(realmDataBeers.first!))
    }
    
    func test_RandomBeer_realm_save() {
        var realmDataBeers = [Beer]()
        
        realmManager.localRandom { result in
            switch result {
            case .success(let beers):
                realmDataBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers).toEventually(contain(realmDataBeers))
        
    }
}
