//
//  BeerListMock.swift
//  RIBs-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

import Moya
import RIBs
import RxRelay
import RxSwift
import UIKit

@testable import RIBs_snapKit

// MARK: - LoggedOutRoutingMock class

/// A LoggedOutRoutingMock class used for testing.
class BeerListRoutingMock: BeerListRouting {
    // Variables
    var viewControllable: ViewControllable
    var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
    var interactableSetCallCount = 0
    var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
    var childrenSetCallCount = 0
    var lifecycleSubject: PublishSubject<RouterLifecycle> = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
    var lifecycleSubjectSetCallCount = 0
    var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }
    
    var showAlertCallCount: Int = 0
    
    init(interactable: Interactable, viewControllable: ViewControllable) {
        self.interactable = interactable
        self.viewControllable = viewControllable
    }
    
    func load() {
    }
    
    func attachChild(_ child: Routing) {
    }
    
    func detachChild(_ child: Routing) {
    }
    
    func showAlert(string: String) {
        showAlertCallCount += 1
    }
}

// MARK: - LoggedOutViewControllableMock class

/// A LoggedOutViewControllableMock class used for testing.
class BeerListViewControllableMock: BeerListViewControllable, BeerListPresentable {
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0
    
    var listener: BeerListPresentableListener?
    
    var input: BeerListPresentableInput?
    var output: BeerListPresentableOutput?
    
    let viewLoadRelay = PublishRelay<Void>()
    let refreshRelay = PublishRelay<Void>()
    let nextPageRelay = PublishRelay<Void>()
    
    func viewDidLoad() {
        self.viewLoadRelay.accept(())
    }
    
    func refresh() {
        self.refreshRelay.accept(())
    }
    
    init() { self.input = self }
}

extension BeerListViewControllableMock: BeerListPresentableInput {
    var viewLoadTrigger: Observable<Void> { return viewLoadRelay.asObservable() }
    
    var refreshTrigger: Observable<Void> {  return refreshRelay.asObservable() }
    
    var nextPageTrigger: Observable<Void> { return nextPageRelay.asObservable() }
}

// MARK: - LoggedOutLoggedOutListenerMock class

/// A LoggedOutLoggedOutListenerMock class used for testing.
class BeerListListenerMock: BeerListListener {
    var goDetailBeerCountHandler: (() -> ())?
    var goDetailBeerCount: Int = 0
    
    func goDetailBeer(beer: Beer) {
        goDetailBeerCount += 1
        goDetailBeerCountHandler?()
    }
}

/// A LoggedOutServiceMock class used for testing.
class NetworkingApiMock: NetworkingService {
    
    var requestHandler: (() -> Bool)?
    var requestCount: Int = 0
    
    func getBeerFromJson(_ api: BeerAPI) -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        switch api {
        case .getBeerList:
            return bundle!.decode([Beer].self, from: "BeerList.json")
        case .getDetailBeer:
            break
        case.random:
            return bundle!.decode([Beer].self, from: "RandomBeer.json")
        case .searchID:
            return bundle!.decode([Beer].self, from: "SingleBeer.json")
        }
        return [Beer]()
    }
    
    func request(_ api: BeerAPI) -> Single<[Beer]> {
        requestCount += 1
        if requestHandler!() {
            return Single.just(getBeerFromJson(api))
        } else {
            return Single.error(MoyaError.requestMapping(""))
        }
    }
}
