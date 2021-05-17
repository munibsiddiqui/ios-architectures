//
//  RandomBeerMock.swift
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
class RandomBeerRoutingMock: RandomBeerRouting {
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
class RandomBeerViewControllableMock: RandomBeerViewControllable, RandomBeerPresentable {
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0
    
    var listener: RandomBeerPresentableListener?
    
    var input: RandomBeerPresentableInput?
    var output: RandomBeerPresentableOutput?
    
    let buttonRelay = PublishRelay<Void>()
    
    func viewDidLoad() {
        self.buttonRelay.accept(())
    }
    
    func random() {
        self.buttonRelay.accept(())
    }
    
    init() { self.input = self }
}

extension RandomBeerViewControllableMock: RandomBeerPresentableInput {
    var buttonTrigger: Observable<Void> { buttonRelay.asObservable() }
}

// MARK: - LoggedOutLoggedOutListenerMock class

/// A LoggedOutLoggedOutListenerMock class used for testing.
class RandomBeerListenerMock: RandomBeerListener {
    
}
