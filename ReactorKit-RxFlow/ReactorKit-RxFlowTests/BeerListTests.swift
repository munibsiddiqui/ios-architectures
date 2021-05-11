//
//  MVVM_RxSwift_snapKitTests.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/29.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import ReactorKit_RxFlow

class BeerListTests: XCTestCase {
    // View -> Action
    func test_View_Action_refresh() {
        // 1. Prepare Stubbed Reactor
        let reactor = BeerListReactor()
        reactor.isStubEnabled = true
        
        // 2. Prepare View that injected stubbed Reactor
        let view = BeerListVC(reactor: reactor)
        
        // 3. Send refresh Action
        view.refreshControl.sendActions(for: .valueChanged)
        
        XCTAssertEqual(reactor.stub.actions.last, .refresh)
    }
    
    // State -> View
    func test_View_State_isLoading() {
        let reactor = BeerListReactor()
        reactor.isStubEnabled = true
        
        let view = BeerListVC(reactor: reactor)
        
        reactor.stub.state.value = BeerListReactor.State(isLoading: true)
        
        XCTAssertEqual(view.activityIndicator.isAnimating, true)
    }
    
    // Action -> State
    func test_Reactor_State_refresh() {
        let reactor = BeerListReactor()
        
        reactor.action.onNext(.refresh)
        
        XCTAssertEqual(reactor.currentState.isRefreshing, true)
    }
    
    // Action -> State
    func test_Reactor_viewWillAppear_n_refresh() {
        let beerListJson = Bundle.getBeerFromJson(.getBeerList(page: 1))
        
        let reactor = BeerListReactor(networkingApi: MockNetworkingAPI())
        reactor.action.onNext(.viewWillAppear)
        reactor.action.onNext(.refresh)
        
        XCTAssertEqual(reactor.currentState.list, beerListJson)
    }
    
}
