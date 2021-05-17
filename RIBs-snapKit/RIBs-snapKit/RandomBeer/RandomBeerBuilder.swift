//
//  RandomBeerBuilder.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs

protocol RandomBeerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RandomBeerComponent: Component<RandomBeerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RandomBeerBuildable: Buildable {
    func build(withListener listener: RandomBeerListener) -> RandomBeerRouting
}

final class RandomBeerBuilder: Builder<RandomBeerDependency>, RandomBeerBuildable {

    override init(dependency: RandomBeerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RandomBeerListener) -> RandomBeerRouting {
        let viewController = RandomBeerViewController()
        let interactor = RandomBeerInteractor(presenter: viewController)
        interactor.listener = listener
        return RandomBeerRouter(interactor: interactor, viewController: viewController)
    }
}
