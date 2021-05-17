//
//  SearchBeerInteractorTests.swift
//  RIBs-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

@testable import RIBs_snapKit
import XCTest

final class SearchBeerInteractorTests: XCTestCase {

    private var interactor: SearchBeerInteractor!
    var networkingApi: NetworkingApiMock!
    var listener: SearchBeerListenerMock!
    var viewController: SearchBeerViewControllableMock!
    var router: SearchBeerRoutingMock!
    // TODO: declare other objects and mocks you need as private vars
    
    override func setUp() {
        super.setUp()
        
        viewController = SearchBeerViewControllableMock()
        networkingApi = NetworkingApiMock()
        listener = SearchBeerListenerMock()
        interactor = SearchBeerInteractor(presenter: viewController, networkingApi: networkingApi)
        interactor.listener = listener
        viewController.listener = interactor
        
        router = SearchBeerRoutingMock(interactable: interactor, viewControllable: viewController)
        interactor.router = router
        
        router.load()
        router.interactable.activate()
        
        // TODO: instantiate objects and mocks
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_success() {
        // Given
        networkingApi.requestHandler = { () in true }
        
        // When
        viewController.search(string: "3")
        
        // Then
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        XCTAssertEqual(interactor.beer.value, bundle!.decode([Beer].self, from: "SingleBeer.json"))
        XCTAssertEqual(networkingApi.requestCount, 1)
    }
    
    func test_viewDidLoad_fail() {
        // Given
        networkingApi.requestHandler = { () in false }
        
        // When
        viewController.search(string: "3")
        
        // Then
        XCTAssertEqual(interactor.beer.value, [])
        XCTAssertEqual(networkingApi.requestCount, 1)
        XCTAssertEqual(router.showAlertCallCount, 1)
    }
}
