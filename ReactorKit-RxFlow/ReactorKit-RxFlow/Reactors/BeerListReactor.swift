//
//  BeerListReactor.swift
//  ReactorKit
//
//  Created by GoEun Jeong on 2021/05/10.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxFlow

final class BeerListReactor: Reactor, Stepper {
    let steps = PublishRelay<Step>()
    
    enum Action {
        case viewWillAppear
        case refresh
        case nextPage
        case detailBeer(Beer)
    }
    
    enum Mutation {
        case setBeers([Beer])
        case appendBeers([Beer])
        case setRefreshing(Bool)
        case setError(String)
        case setLoading(Bool)
        case detailBeer(Beer)
    }
    
    struct State {
        var list: [Beer] = .init()
        var isRefreshing: Bool = false
        var isLoading: Bool = false
    }
    
    var page: Int = 1
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
                networkingApi.request(.getBeerList(page: self.page))
                .asObservable()
                .map { return .setBeers($0) }
                .catchError {
                    return .just(.setError($0.localizedDescription)) }
            return .concat([startLoading, beerList, endLoading])
            
        case .refresh:
            self.page = 1
            let startRefreshing: Observable<Mutation> = .just(.setRefreshing(true))
            let endRefreshing: Observable<Mutation> = .just(.setRefreshing(false))
            let beerList: Observable<Mutation> =
                networkingApi.request(.getBeerList(page: self.page))
                .asObservable()
                .map { return .setBeers($0) }
                .catchError { return .just(.setError($0.localizedDescription)) }
            return .concat([startRefreshing, beerList, endRefreshing])
            
        case .nextPage:
            self.page += 1
            let startRefreshing: Observable<Mutation> = .just(.setRefreshing(true))
            let endRefreshing: Observable<Mutation> = .just(.setRefreshing(false))
            let beerList: Observable<Mutation> =
                networkingApi.request(.getBeerList(page: self.page))
                .asObservable()
                .map { return .appendBeers($0) }
                .catchError { return .just(.setError($0.localizedDescription)) }
            return .concat([startRefreshing, beerList, endRefreshing])
            
        case .detailBeer(let beer):
            return Observable<Mutation>.just(.detailBeer(beer))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setBeers(let beers):
            state.list = beers
        
        case .appendBeers(let beers):
            state.list += beers
            
        case .setRefreshing(let isRefreshing):
            state.isRefreshing = isRefreshing
            
        case .setLoading(let isLoading):
            state.isLoading = isLoading
            
        case .setError(let error):
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)  {
                self.steps.accept(BeerStep.alert(error))
            }
        case .detailBeer(let beer):
            self.steps.accept(BeerStep.BeerDetailIsPicked(beer: beer))
        }
        
        return state
    }
}
