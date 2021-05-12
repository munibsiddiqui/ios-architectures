//
//  RandomBeerTests.swift
//  VIPER-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/12.
//

import Foundation
import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import VIPER_snapKit

class RandomBeerTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    var presenter: RandomBeerPresenter!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN

    override func setUp() {
        presenter = Mock.shared.getRandomBeerPresenter()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
        scheduler.createHotObservable([.next(100, ())])
            .bind(to: presenter.input.buttonTrigger)
            .disposed(by: disposeBag)
    }
    
    func testIndicatorEvents() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Bool.self)
        
        presenter.output.isLoading
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
    
    func testBeerData() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Beer?.self)
        
        presenter.output.beer
            .map({ $0.first })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Beer?>>] = [
            .next(0, nil),
            .next(100, Beer(id: 1, name: "Buzz", description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", imageURL: "https://images.punkapi.com/v2/keg.png"))
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }

}
