//
//  SearchBeer.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/09.
//

import RxFlow
import UIKit

class SearchBeerFlow: Flow {
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
        case .SearchBeerIsRequired:
            return navigateToSearchBeerScreen()
        default:
            return .none
        }
    }

    private func navigateToSearchBeerScreen() -> FlowContributors {
        let vc = SearchBeerVC()
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
}
