//
//  SearchBeerMock.swift
//  RIBs-snapKitTests
//
//  Created by GoEun Jeong on 2021/05/17.
//

import RIBs
import RxRelay
import RxSwift
import UIKit

@testable import RIBs_snapKit

// MARK: - LoggedOutRoutingMock class

/// A LoggedOutRoutingMock class used for testing.
class SearchBeerRoutingMock: SearchBeerRouting {
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
class SearchBeerViewControllableMock: SearchBeerViewControllable, SearchBeerPresentable {
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0
    
    var listener: SearchBeerPresentableListener?
    
    var input: SearchBeerPresentableInput?
    var output: SearchBeerPresentableOutput?
    
    let searchRelay = PublishRelay<String>()
    
    func search(string: String) {
        self.searchRelay.accept(string)
    }
    
    init() { self.input = self }
}

extension SearchBeerViewControllableMock: SearchBeerPresentableInput {
    var searchTrigger: Observable<String> { searchRelay.asObservable() }
    
}

// MARK: - LoggedOutLoggedOutListenerMock class

/// A LoggedOutLoggedOutListenerMock class used for testing.
class SearchBeerListenerMock: SearchBeerListener {
    
}
