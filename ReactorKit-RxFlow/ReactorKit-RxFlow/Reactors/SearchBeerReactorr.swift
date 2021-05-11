//
//  SearchBeerReactor.swift
//  ReactorKit-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/10.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxFlow

final class SearchBeerReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    
    enum Action {
        case search(id: Int)
    }
    
    enum Mutation {
        case setBeer([Beer])
        case setError(String)
        case setLoading(Bool)
    }
    
    struct State {
        var beer: [Beer] = .init()
        var isLoading: Bool = false
    }
    
    let initialState: State = .init()
    
    private let networkingApi: NetworkingService!
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search(let id):
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            let beerList: Observable<Mutation> =
                networkingApi.request(.searchID(id: id))
                .asObservable()
                .distinctUntilChanged()
                .map { return .setBeer($0) }
                .catchError { return .just(.setError($0.localizedDescription)) }
            return .concat([startLoading, beerList, endLoading])
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setBeer(let beers):
            state.beer = beers
            
        case .setLoading(let isLoading):
            state.isLoading = isLoading
            
        case .setError(let error):
            self.steps.accept(BeerStep.alert(error))
        }
        
        return state
    }
}
