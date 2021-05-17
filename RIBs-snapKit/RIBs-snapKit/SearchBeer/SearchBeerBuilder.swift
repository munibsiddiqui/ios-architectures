//
//  SearchBeerBuilder.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs

protocol SearchBeerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchBeerComponent: Component<SearchBeerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchBeerBuildable: Buildable {
    func build(withListener listener: SearchBeerListener) -> SearchBeerRouting
}

final class SearchBeerBuilder: Builder<SearchBeerDependency>, SearchBeerBuildable {

    override init(dependency: SearchBeerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchBeerListener) -> SearchBeerRouting {
        let component = SearchBeerComponent(dependency: dependency)
        let viewController = SearchBeerViewController()
        let interactor = SearchBeerInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchBeerRouter(interactor: interactor, viewController: viewController)
    }
}
