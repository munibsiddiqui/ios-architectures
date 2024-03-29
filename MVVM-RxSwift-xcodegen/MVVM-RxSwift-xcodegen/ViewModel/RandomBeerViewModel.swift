//
//  RandomBeerViewModel.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import RxSwift
import RxCocoa

class RandomBeerViewModel {
    private let disposeBag = DisposeBag()
    private let networkingApi: NetworkingService!
    
    // MARK: - ViewModelType
    
    struct Input {
        let buttonTrigger = PublishRelay<Void>()
    }
    
    struct Output {
        let beer = BehaviorRelay<[Beer]>(value: [])
        let isLoading = BehaviorRelay<Bool>(value: false)
        let errorRelay = PublishRelay<NetworkingError>()
    }
    
    let input = Input()
    let output = Output()
    
    init(networkingApi: NetworkingService = NetworkingApi()) {
        self.networkingApi = networkingApi
        let activityIndicator = ActivityIndicator()
        
        input.buttonTrigger
            .asObservable()
            .flatMapLatest {
                networkingApi.request(.random)
                    .trackActivity(activityIndicator)
                    .do(onError: { self.output.errorRelay.accept($0 as! NetworkingError) })
                    .catchErrorJustReturn([])
            }
            .bind(to: output.beer)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: output.isLoading)
            .disposed(by: disposeBag)
    }
}
