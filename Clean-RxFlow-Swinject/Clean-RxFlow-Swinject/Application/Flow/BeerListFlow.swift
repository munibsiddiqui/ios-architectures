//
//  BeerListFlow.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/09.
//

import RxFlow
import UIKit

class BeerListFlow: Flow {
    @Inject var vc: BeerListVC
    @Inject var vm: BeerListViewModel
    
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
//        let vc = BeerListVC()
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }

    private func navigateToBeerDetailScreen (beer: Beer) -> FlowContributors {
        let vc = DetailBeerVC(beer: beer)
        vc.hidesBottomBarWhenPushed = true
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vm))
    }
    
    private func alert(string: String) -> FlowContributors {
        self.rootViewController.showErrorAlert(with: string)
        return .none
    }
}
