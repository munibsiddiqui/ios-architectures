//
//  RandomBeerTests.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/30.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import ReactorKit_RxFlow

class RandomBeerTests: XCTestCase {
    // State -> View
    func test_View_State_isLoading() {
        let reactor = RandomBeerReactor()
        reactor.isStubEnabled = true
        
        let view = RandomBeerVC(reactor: reactor)
        
        reactor.stub.state.value = RandomBeerReactor.State(isLoading: true)
        
        XCTAssertEqual(view.activityIndicator.isAnimating, true)
    }
    
    // Action -> State
    func test_Reactor_State_isLoading() {
        let reactor = RandomBeerReactor()
        
        reactor.action.onNext(.random)
        
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }
    
    // Action -> State
    func test_Reactor_viewWillAppear() {
        let beerListJson = Bundle.getBeerFromJson(.random)
        
        debugPrint(beerListJson)
        
        let reactor = RandomBeerReactor(networkingApi: MockNetworkingAPI())
        reactor.action.onNext(.viewWillAppear)
        
        debugPrint(reactor.currentState.beer)
        
        XCTAssertEqual(reactor.currentState.beer, beerListJson)
    }
    
    // Action -> State
    func test_Reactor_random() {
        let beerListJson = Bundle.getBeerFromJson(.random)
        
        let reactor = RandomBeerReactor(networkingApi: MockNetworkingAPI())
        reactor.action.onNext(.random)
        
        XCTAssertEqual(beerListJson, reactor.currentState.beer)
    }
    
}
