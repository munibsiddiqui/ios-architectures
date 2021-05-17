//
//  SearchBeerInteractor.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs
import RxSwift
import RxRelay

protocol SearchBeerRouting: ViewableRouting {
    func showAlert(string: String)
}

protocol SearchBeerPresentableInput: AnyObject {
    var searchTrigger: Observable<String> { get }
}

protocol SearchBeerPresentableOutput: AnyObject {
    var beer: BehaviorRelay<[Beer]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol SearchBeerPresentable: Presentable {
    var listener: SearchBeerPresentableListener? { get set }
    
    var input: SearchBeerPresentableInput? { get set }
    var output: SearchBeerPresentableOutput? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchBeerListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchBeerInteractor: PresentableInteractor<SearchBeerPresentable>, SearchBeerInteractable, SearchBeerPresentableListener {

    weak var router: SearchBeerRouting?
    weak var listener: SearchBeerListener?
    private let disposeBag = DisposeBag()
    private let networkingApi: NetworkingService!
    
    private let beerRelay = BehaviorRelay<[Beer]>(value: [Beer]())
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchBeerPresentable,
                  networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.output = self
        
        let activityIndicator = ActivityIndicator()
        guard let input = presenter.input else { return }
        
        input.searchTrigger
            .asObservable()
            .flatMapLatest { id in
                networkingApi.request(.searchID(id: Int(id) ?? 0))
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

extension SearchBeerInteractor: SearchBeerPresentableOutput {
    var beer: BehaviorRelay<[Beer]> { beerRelay }
    
    var isLoading: BehaviorRelay<Bool> { isLoadingRelay }
}
