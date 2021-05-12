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
import Nimble

@testable import Clean_MVVM

class SearchBeerTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    var viewModel: SearchBeerViewModel!
    var scheduler: TestScheduler!

    // MARK: - GIVEN
    
    override func setUp() {
        viewModel = TestDI.shared.getSearchBeerVM()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
        scheduler.createHotObservable([.next(100, "3")])
            .bind(to: viewModel.input.searchTrigger)
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
        
        expect(observer.events).to(equal(exceptEvents))
    }
    
    func testBeerData() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Beer?.self)
        
        viewModel.output.beer
            .map({ $0.first })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Beer?>>] = [
            .next(0, nil),
            .next(100, Beer(id: 3, name: "Berliner Weisse With Yuzu - B-Sides", description: "Japanese citrus fruit intensifies the sour nature of this German classic.", imageURL: "https://images.punkapi.com/v2/keg.png"))
        ]
        
        // MARK: - THEN
        
        expect(observer.events).to(equal(exceptEvents))
    }

}
