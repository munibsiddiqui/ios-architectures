//
//  DetailViewController.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import UIKit
import SnapKit

class DetailBeerVC: UIViewController {
    private let detailView = BeerView()
    private let beer: Beer
    
    private let indicator = UIActivityIndicatorView()
    
    private let coordinator: BeerListCoordinator
    
    // MARK: - Initialization
    
    init(coordinator: BeerListCoordinator, beer: Beer) {
        self.coordinator = coordinator
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.coordinator.didFinish(coordinator: self.coordinator)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(detailView)
        detailView.setupView(model: beer)
        detailView.addSubview(indicator)
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
    }
}
