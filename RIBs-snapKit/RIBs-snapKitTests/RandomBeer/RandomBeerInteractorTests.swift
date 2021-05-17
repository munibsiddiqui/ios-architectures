//
//  RandomBeerInteractorTests.swift
//  RIBs-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

@testable import RIBs_snapKit
import XCTest

final class RandomBeerInteractorTests: XCTestCase {

    private var interactor: RandomBeerInteractor!
    var networkingApi: NetworkingApiMock!
    var listener: RandomBeerListenerMock!
    var viewController: RandomBeerViewControllableMock!
    var router: RandomBeerRoutingMock!
    // TODO: declare other objects and mocks you need as private vars
    
    override func setUp() {
        super.setUp()
        
        viewController = RandomBeerViewControllableMock()
        networkingApi = NetworkingApiMock()
        listener = RandomBeerListenerMock()
        interactor = RandomBeerInteractor(presenter: viewController, networkingApi: networkingApi)
        interactor.listener = listener
        viewController.listener = interactor
        
        router = RandomBeerRoutingMock(interactable: interactor, viewControllable: viewController)
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
        viewController.viewDidLoad()
        
        // Then
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        XCTAssertEqual(interactor.beer.value, bundle!.decode([Beer].self, from: "RandomBeer.json"))
        XCTAssertEqual(networkingApi.requestCount, 1)
    }
    
    func test_viewDidLoad_refresh_success() {
        // Given
        networkingApi.requestHandler = { () in true }
        
        // When
        viewController.viewDidLoad()
        viewController.random()
        
        // Then
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        XCTAssertEqual(interactor.beer.value, bundle!.decode([Beer].self, from: "RandomBeer.json"))
        XCTAssertEqual(networkingApi.requestCount, 2)
    }
    
    func test_viewDidLoad_fail() {
        // Given
        networkingApi.requestHandler = { () in false }
        
        // When
        viewController.viewDidLoad()
        
        // Then
        XCTAssertEqual(interactor.beer.value, [])
        XCTAssertEqual(networkingApi.requestCount, 1)
        XCTAssertEqual(router.showAlertCallCount, 1)
    }
}
