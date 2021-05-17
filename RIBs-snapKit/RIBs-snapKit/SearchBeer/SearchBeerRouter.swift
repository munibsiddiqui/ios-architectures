//
//  SearchBeerRouter.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs

protocol SearchBeerInteractable: Interactable {
    var router: SearchBeerRouting? { get set }
    var listener: SearchBeerListener? { get set }
}

protocol SearchBeerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchBeerRouter: ViewableRouter<SearchBeerInteractable, SearchBeerViewControllable>, SearchBeerRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchBeerInteractable, viewController: SearchBeerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func showAlert(string: String) {
        self.viewController.uiviewController.showErrorAlert(with: string)
    }
}
