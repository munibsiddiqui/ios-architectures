//
//  BeerListRouter.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs

protocol BeerListInteractable: Interactable {
    var router: BeerListRouting? { get set }
    var listener: BeerListListener? { get set }
}

protocol BeerListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BeerListRouter: ViewableRouter<BeerListInteractable, BeerListViewControllable>, BeerListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BeerListInteractable, viewController: BeerListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func showAlert(string: String) {
        self.viewController.uiviewController.showErrorAlert(with: string)
    }
}
