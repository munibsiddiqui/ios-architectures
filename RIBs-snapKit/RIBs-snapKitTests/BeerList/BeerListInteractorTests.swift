//
//  BeerListInteractorTests.swift
//  RIBs-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

@testable import RIBs_snapKit
import XCTest
import Moya

final class BeerListInteractorTests: XCTestCase {
    
    private var interactor: BeerListInteractor!
    var networkingApi: NetworkingApiMock!
    var listener: BeerListListenerMock!
    var viewController: BeerListViewControllableMock!
    var router: BeerListRoutingMock!
    // TODO: declare other objects and mocks you need as private vars
    
    override func setUp() {
        super.setUp()
        
        viewController = BeerListViewControllableMock()
        networkingApi = NetworkingApiMock()
        listener = BeerListListenerMock()
        interactor = BeerListInteractor(presenter: viewController, networkingApi: networkingApi)
        interactor.listener = listener
        viewController.listener = interactor
        
        router = BeerListRoutingMock(interactable: interactor, viewControllable: viewController)
        interactor.router = router
        
        router.load()
        router.interactable.activate()
        
        // TODO: instantiate objects and mocks
    }
    
    // MARK: - Tests
    
    func test_login_success() {
        viewController.listener?.goDetailBeer(beer: Beer())
        
        XCTAssertEqual(listener.goDetailBeerCount, 1)
    }
    
    func test_viewDidLoad_success() {
        // Given
        networkingApi.requestHandler = { () in true }
        
        // When
        viewController.viewDidLoad()
        
        // Then
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        XCTAssertEqual(interactor.list.value, bundle!.decode([Beer].self, from: "BeerList.json"))
        XCTAssertEqual(networkingApi.requestCount, 1)
    }
    
    func test_viewDidLoad_refresh_success() {
        // Given
        networkingApi.requestHandler = { () in true }
        
        // When
        viewController.viewDidLoad()
        viewController.refresh()
        
        // Then
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        XCTAssertEqual(interactor.list.value, bundle!.decode([Beer].self, from: "BeerList.json"))
        XCTAssertEqual(networkingApi.requestCount, 2)
    }
    
    func test_viewDidLoad_fail() {
        // Given
        networkingApi.requestHandler = { () in false }
        
        // When
        viewController.viewDidLoad()
        
        // Then
        XCTAssertEqual(interactor.list.value, [])
        XCTAssertEqual(networkingApi.requestCount, 1)
        XCTAssertEqual(router.showAlertCallCount, 1)
    }
}
