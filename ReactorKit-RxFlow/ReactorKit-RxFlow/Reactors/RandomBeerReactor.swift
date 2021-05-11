//
//  RandomBeerReactor.swift
//  Reactor
//
//  Created by GoEun Jeong on 2021/05/10.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxFlow

final class RandomBeerReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    
    enum Action {
        case viewWillAppear
        case random
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
        case .viewWillAppear:
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            let beerList: Observable<Mutation> =
                networkingApi.request(.random)
                .asObservable()
                .distinctUntilChanged()
                .map { return .setBeer($0) }
                .catchError { return .just(.setError($0.localizedDescription)) }
            return .concat([startLoading, beerList, endLoading])
            
        case .random:
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            let beerList: Observable<Mutation> =
                networkingApi.request(.random)
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
