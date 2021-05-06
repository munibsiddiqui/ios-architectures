//
//  RandomBeerTests.swift
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

@testable import MVVM_C_RxSwift

class RandomBeerTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    var viewModel: RandomBeerViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    
    override func spec() {
        describe("RandomBeer ViewDidLoad") { // Given
            beforeEach {
                let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<BeerAPI>(stubClosure: { _ in .immediate }))
                self.viewModel = RandomBeerViewModel(networkingApi: mockNetworkingAPI)
                self.scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
                
                self.scheduler.createHotObservable([.next(100, ())])
                    .bind(to: self.viewModel.input.buttonTrigger)
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
            
            context("Get a Random Beer") { // When
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
                        .next(100, Beer(id: 1, name: "Buzz", description: "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", imageURL: "https://images.punkapi.com/v2/keg.png"))
                    ]
                    
                    expect(observer.events).to(equal(exceptEvents))
                }
            }
        }
    }
}
