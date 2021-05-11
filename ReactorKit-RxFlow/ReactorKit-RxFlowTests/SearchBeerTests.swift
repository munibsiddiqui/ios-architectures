//
//  SearchBeerTests\.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/30.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import ReactorKit_RxFlow

class SearchBeerTests: XCTestCase {
    // State -> View
    func test_View_State_isLoading() {
        let reactor = SearchBeerReactor()
        reactor.isStubEnabled = true
        
        let view = SearchBeerVC(reactor: reactor)
        
        reactor.stub.state.value = SearchBeerReactor.State(isLoading: true)
        
        XCTAssertEqual(view.activityIndicator.isAnimating, true)
    }
    
    // Action -> State
    func test_Reactor_State_isLoading() {
        let reactor = SearchBeerReactor()
        
        reactor.action.onNext(.search(id: 0))
        
        XCTAssertEqual(reactor.currentState.isLoading, true)
    }
    
    // Action -> State
    func test_Reactor_random() {
        let beerListJson = Bundle.getBeerFromJson(.searchID(id: 3))
        
        let reactor = SearchBeerReactor(networkingApi: MockNetworkingAPI())
        reactor.action.onNext(.search(id: 3))
        
        XCTAssertEqual(beerListJson, reactor.currentState.beer)
    }
    
}
