//
//  SqliteManagerTests.swift
//  MVVM-RxSwift-sqliteTests
//
//  Created by GoEun Jeong on 2021/05/11.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
import Nimble

@testable import MVVM_RxSwift_sqlite

class SqliteManagerTests: XCTestCase {
    let sqliteManager = SqliteManager()
    let jsonBeers = Bundle.getBeerFromJson(.getBeerList(page: 1))
    
    override func setUp() {
        for beer in jsonBeers {
            sqliteManager.saveBeer(beer: beer)
        }
    }
    
    func test_beerList_sqlite_save() {
        var sqliteBeers = [Beer]()
        
        sqliteManager.getLocalBeerList(page: 1) { result in
            switch result {
            case .success(let beers):
                sqliteBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers).to(equal(sqliteBeers))
    }
    
    func test_SearchBeer_sqlite_save() {
        var sqliteBeers = [Beer]()
        
        sqliteManager.searchLocalID(id: 3) { result in
            switch result {
            case .success(let beers):
                sqliteBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers[2]).to(equal(sqliteBeers.first!))
    }
    
    func test_RandomBeer_sqlite_save() {
        var sqliteBeers = [Beer]()
        
        sqliteManager.localRandom { result in
            switch result {
            case .success(let beers):
                sqliteBeers = beers
            case .failure: break
            }
        }
        
        expect(self.jsonBeers).toEventually(contain(sqliteBeers))
        
    }
}
