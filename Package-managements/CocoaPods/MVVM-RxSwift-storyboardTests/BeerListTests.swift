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

@testable import MVVM_RxSwift_storyboard

class BeerListTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    var viewModel: BeerListViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN

    override func setUp() {
        viewModel = BeerListViewModel(networkingApi: MockNetworkingAPI())
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
        scheduler.createHotObservable([.next(100, ())])
            .bind(to: viewModel.input.viewDidLoad)
            .disposed(by: disposeBag)
    }

    func testIndicatorEvents() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.output.isLoading
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(100, true),
            .next(100, false)
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
    
    func testListCount() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Int.self)
        
        viewModel.output.list
            .map { $0.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(0, 0),
            .next(100, 25)
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
    
    func testBeerData() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Beer?.self)
        
        viewModel.output.list
            .map({ $0.last })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Beer?>>] = [
            .next(0, nil),
            .next(100, Beer(id: 25, name: "Bad Pixie", description: "2008 Prototype beer, a 4.7% wheat ale with crushed juniper berries and citrus peel.", imageURL: "https://images.punkapi.com/v2/25.png"))
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }

}
