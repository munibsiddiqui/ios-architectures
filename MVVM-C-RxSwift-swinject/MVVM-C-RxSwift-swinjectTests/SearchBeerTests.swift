//
//  SearchBeerTests\.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/30.
//

import XCTest
import RxSwift
import RxTest
import Nimble
import Quick
import Moya

@testable import MVVM_C_RxSwift_snapKit

class SearchBeerTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    var viewModel: SearchBeerViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    
    override func spec() {
        describe("SearchBeer search '3'") { // Given
            beforeEach {
                let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<BeerAPI>(stubClosure: { _ in .immediate }))
                self.viewModel = SearchBeerViewModel(networkingApi: mockNetworkingAPI)
                self.scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
                
                self.scheduler.createHotObservable([.next(100, "3")])
                    .bind(to: self.viewModel.input.searchTrigger)
                    .disposed(by: self.disposeBag)
            }
            
            context("isLoading") { // When
                var observer: TestableObserver<Bool>!
                
                beforeEach {
                    observer = self.scheduler.createObserver(Bool.self)
                    
                    self.viewModel.output.isLoading
                        .bind(to: observer)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.start()
                }
                
                it("Test") { // Then
                    let exceptEvents: [Recorded<Event<Bool>>] = [
                        .next(0, false),
                        .next(100, true),
                        .next(100, false)
                    ]
                    
                    expect(observer.events).to(equal(exceptEvents))
                }
            }
            
            context("Get a Searched Beer") { // When
                var observer: TestableObserver<Beer?>!
                
                beforeEach {
                    observer = self.scheduler.createObserver(Beer?.self)
                    
                    self.viewModel.output.beer
                        .map{ $0.first }
                        .bind(to: observer)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.start()
                }
                
                it("Test matches a Beer") { // Then
                    let exceptEvents: [Recorded<Event<Beer?>>] = [
                        .next(0, nil),
                        .next(100, Beer(id: 3, name: "Berliner Weisse With Yuzu - B-Sides", description: "Japanese citrus fruit intensifies the sour nature of this German classic.", imageURL: "https://images.punkapi.com/v2/keg.png"))
                    ]
                    
                    expect(observer.events).to(equal(exceptEvents))
                }
            }
        }
    }
}
