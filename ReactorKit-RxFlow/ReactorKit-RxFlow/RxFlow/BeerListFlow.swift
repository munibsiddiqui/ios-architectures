//
//  BeerListFlow.swift
//  ReactorKit-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/10.
//

import RxFlow
import UIKit

class BeerListFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? BeerStep else { return .none }

        switch step {
        case .BeerListIsRequired:
            return navigateToBeerListScreen()
        case .BeerDetailIsPicked(let beer):
            return navigateToBeerDetailScreen(beer: beer)
        case .alert(let string):
            return alert(string: string)
        default:
            return .none
        }
    }

    private func navigateToBeerListScreen() -> FlowContributors {
        let vc = BeerListVC(reactor: BeerListReactor())
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }

    private func navigateToBeerDetailScreen (beer: Beer) -> FlowContributors {
        let vc = DetailBeerVC(beer: beer)
        vc.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: BeerListReactor()))
    }
    
    private func alert(string: String) -> FlowContributors {
        self.rootViewController.showErrorAlert(with: string)
        return .none
    }
}
