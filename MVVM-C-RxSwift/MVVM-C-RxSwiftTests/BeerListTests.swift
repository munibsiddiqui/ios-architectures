//
//  MVVM_RxSwift_snapKitTests.swift
//  MVVM-RxSwift-snapKitTests
//
//  Created by GoEun Jeong on 2021/04/29.
//

import XCTest
import RxSwift
import RxTest
import Nimble
import Quick
import Moya

@testable import MVVM_C_RxSwift

class BeerListTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    var viewModel: BeerListViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    
    override func spec() {
        describe("BeerList ViewDidLoad") { // Given
            beforeEach {
                let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<BeerAPI>(stubClosure: { _ in .immediate }))
                self.viewModel = BeerListViewModel(networkingApi: mockNetworkingAPI)
                self.scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
                
                self.scheduler.createHotObservable([.next(100, ())])
                    .bind(to: self.viewModel.input.viewDidLoad)
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
            
            context("BeerList Count") { // When
                var observer: TestableObserver<Int>!
                
                beforeEach {
                    observer = self.scheduler.createObserver(Int.self)
                    
                    self.viewModel.output.list
                        .map { $0.count }
                        .bind(to: observer)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.start()
                }
                
                it("Test matches 25") { // Then
                    let exceptEvents: [Recorded<Event<Int>>] = [
                        .next(0, 0),
                        .next(100, 25)
                    ]
                    
                    expect(observer.events).to(equal(exceptEvents))
                }
            }
            
            context("BeerList list") { // When
                var observer: TestableObserver<Beer?>!
                
                beforeEach {
                    observer = self.scheduler.createObserver(Beer?.self)
                    
                    self.viewModel.output.list
                        .map({ $0.last })
                        .bind(to: observer)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.start()
                }
                
                it("Test matches Beer Data") { // Then
                    let exceptEvents: [Recorded<Event<Beer?>>] = [
                        .next(0, nil),
                        .next(100, Beer(id: 25, name: "Bad Pixie", description: "2008 Prototype beer, a 4.7% wheat ale with crushed juniper berries and citrus peel.", imageURL: "https://images.punkapi.com/v2/25.png"))
                    ]
                    
                    expect(observer.events).to(equal(exceptEvents))
                }
            }
            
        }
    }
}
