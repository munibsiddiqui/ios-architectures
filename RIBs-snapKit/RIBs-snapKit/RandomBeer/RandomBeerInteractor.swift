//
//  RandomBeerInteractor.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs
import RxSwift
import RxRelay

protocol RandomBeerRouting: ViewableRouting {
    func showAlert(string: String)
}

protocol RandomBeerPresentableInput: AnyObject {
    var buttonTrigger: Observable<Void> { get }
}

protocol RandomBeerPresentableOutput: AnyObject {
    var beer: BehaviorRelay<[Beer]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol RandomBeerPresentable: Presentable {
    var listener: RandomBeerPresentableListener? { get set }
    
    var input: RandomBeerPresentableInput? { get set }
    var output: RandomBeerPresentableOutput? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RandomBeerListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RandomBeerInteractor: PresentableInteractor<RandomBeerPresentable>, RandomBeerInteractable, RandomBeerPresentableListener {

    weak var router: RandomBeerRouting?
    weak var listener: RandomBeerListener?
    private let disposeBag = DisposeBag()
    private let networkingApi: NetworkingService!
    
    private let beerRelay = BehaviorRelay<[Beer]>(value: [Beer]())
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RandomBeerPresentable,
         networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.output = self
        
        let activityIndicator = ActivityIndicator()
        guard let input = presenter.input else { return }
        
        input.buttonTrigger
            .asObservable()
            .flatMapLatest {
                networkingApi.request(.random)
                    .trackActivity(activityIndicator)
                    .do(onError: { self.router?.showAlert(string: $0.localizedDescription) })
                    .catchErrorJustReturn([])
            }
            .bind(to: beerRelay)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension RandomBeerInteractor: RandomBeerPresentableOutput {
    var beer: BehaviorRelay<[Beer]> { return beerRelay }
    
    var isLoading: BehaviorRelay<Bool> { return isLoadingRelay }
}
