//
//  RandomBeerViewController.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import RIBs
import RxSwift
import UIKit

protocol RandomBeerPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RandomBeerViewController: UIViewController, RandomBeerPresentable, RandomBeerViewControllable {

    weak var listener: RandomBeerPresentableListener?
    
    private let randomView = BeerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let disposeBag = DisposeBag()
    var input: RandomBeerPresentableInput?
    var output: RandomBeerPresentableOutput?
    
    private let randomButton = UIButton().then {
        $0.setTitle("Roll Random", for: .normal)
        $0.backgroundColor = UIColor.orange
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        input = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
        self.bindOutput()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        self.navigationItem.accessibilityLabel = "Random by Button"
    }
    
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(randomView)
        view.addSubview(activityIndicator)
        randomView.addSubview(randomButton)
        
        randomView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide).offset(-30)
            $0.width.equalTo(view.snp.width).offset(-30)
            $0.height.equalTo(40)
        }
    }
}

extension RandomBeerViewController: RandomBeerPresentableInput {
    var buttonTrigger: Observable<Void> {
        return Observable.merge([self.rx.viewDidLoad.asObservable(), randomButton.rx.tap.asObservable()])
    }
}

extension RandomBeerViewController {
    private func bindOutput() {
        guard let output = output else { return }
        
        output.beer
            .subscribe(onNext: { [weak self] beer in
                self?.randomView.setupView(model: beer.first ?? Beer(id: nil, name: "Loading...", description: "", imageURL: ""))
            })
            .disposed(by: disposeBag)
        
        output.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
