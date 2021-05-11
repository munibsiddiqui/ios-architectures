//
//  RandomBeerVC.swift
//  MVC-storyboard
//
//  Created by GoEun Jeong on 2021/04/28.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import ReactorKit

class RandomBeerVC: UIViewController, View {
    typealias Reactor = RandomBeerReactor
    
    private let randomView = BeerView()
    let activityIndicator = UIActivityIndicatorView()
    
    var disposeBag = DisposeBag()
    
    private let randomButton = UIButton().then {
        $0.setTitle("Roll Random", for: .normal)
        $0.backgroundColor = UIColor.orange
    }
    
    // MARK: - Initialization
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: Reactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
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
        randomView.addSubview(randomButton)
        randomView.addSubview(activityIndicator)
        
        randomView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide).offset(-30)
            $0.width.equalTo(view.snp.width).offset(-30)
            $0.height.equalTo(40)
        }
    }
    
    private func bindAction(reactor: Reactor) {
        self.rx.viewWillAppear.map { _ in Void() }
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        randomButton.rx.tap
            .map { _ in Reactor.Action.random }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: Reactor) {
        reactor.state.map { $0.beer }
            .subscribe(onNext: { [weak self] beer in
                self?.randomView.setupView(model: beer.first ?? Beer(id: nil, name: "Loading...", description: "", imageURL: ""))
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
