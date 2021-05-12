//
//  BeerListPresenter.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import Foundation
import RxCocoa
import RxSwift

final class BeerListPresenter: BeerListPresenterProtocol {

    // MARK: Properties
    let interactor: BeerListInteractorProtocol
    let router: BeerListRouterProtocol
    
    private var page = 1
    private var disposeBag = DisposeBag()
    
    // MARK: - ViewModelType
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
        let refreshTrigger = PublishRelay<Void>()
        let nextPageTrigger = PublishRelay<Void>()
        let detailBeerTrigger = PublishRelay<Beer>()
    }
    
    struct Output {
        let list = BehaviorRelay<[Beer]>(value: [])
        let isLoading = BehaviorRelay<Bool>(value: false)
        let isRefreshing = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    
    init(interactor: BeerListInteractorProtocol, router: BeerListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        let activityIndicator = ActivityIndicator()
        let refreshIndicator = ActivityIndicator()
        
        input.viewDidLoad
            .asObservable()
            .flatMapLatest {
                interactor.fetchBeerListfromAPI(page: self.page)
                    .trackActivity(activityIndicator)
                    .do(onError: { self.router.showAlert(string: $0.localizedDescription) })
                    .catchErrorJustReturn([])
            }
            .bind(to: output.list)
            .disposed(by: disposeBag)
        
        input.refreshTrigger
            .asObservable()
            .map { self.page = 1 }
            .flatMapLatest {
                interactor.fetchBeerListfromAPI(page: self.page)
                    .trackActivity(refreshIndicator)
                    .do(onError: { self.router.showAlert(string: $0.localizedDescription) })
                    .catchErrorJustReturn([])
            }
            .bind(to: output.list)
            .disposed(by: disposeBag)
        
        
        input.nextPageTrigger
            .asObservable()
            .map { self.page += 1 }
            .flatMapLatest {
                interactor.fetchBeerListfromAPI(page: self.page)
                    .trackActivity(activityIndicator)
                    .do(onError: { self.router.showAlert(string: $0.localizedDescription) })
                    .catchErrorJustReturn([])
            }
            .map { self.output.list.value + $0 }
            .bind(to: output.list)
            .disposed(by: disposeBag)
        
        input.detailBeerTrigger
            .asObservable()
            .subscribe(onNext: { self.router.showBeerDetail(beer: $0) })
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: output.isLoading)
            .disposed(by: disposeBag)
        
        refreshIndicator
            .asObservable()
            .bind(to: output.isRefreshing)
            .disposed(by: disposeBag)
    }
}
