//
//  SearchBeerPresenter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import RxCocoa
import RxSwift

class SearchBeerPresenter: SearchBeerPresenterProtocol {

    // MARK: Properties
    let interactor: SearchBeerInteractorProtocol
    let router: SearchBeerRouterProtocol
    private var disposeBag = DisposeBag()
    
    // MARK: - ViewModelType
    
    struct Input {
        let searchTrigger = PublishRelay<String>()
    }
    
    struct Output {
        let beer = BehaviorRelay<[Beer]>(value: [])
        let isLoading = BehaviorRelay<Bool>(value: false)
    }
    
    let input = Input()
    let output = Output()
    
    
    init(interactor: SearchBeerInteractorProtocol,
         router: SearchBeerRouterProtocol) {
        self.interactor = interactor
        self.router = router
        let activityIndicator = ActivityIndicator()
        
        input.searchTrigger
            .asObservable()
            .flatMapLatest { id in
                interactor.fetchSearchBeerfromAPI(id: Int(id) ?? 0)
                    .trackActivity(activityIndicator)
                    .do(onError: { self.router.showAlert(string: $0.localizedDescription) })
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
