//
//  RandomBeerVC.swift
//  MVC-storyboard
//
//  Created by GoEun Jeong on 2021/04/28.
//

import UIKit
import Then

protocol RandomView: class {
    func onItemsRetrieval(beers: [Beer])
}

class RandomBeerVC: UIViewController {
    private let randomView = BeerView()
    var presenter: RandomBeerViewPresenter!
    
    private let randomButton = UIButton().then {
        $0.setTitle("Roll Random", for: .normal)
        $0.backgroundColor = UIColor.orange
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
        self.presenter.getRandom()
    }
    
    func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        self.navigationItem.accessibilityLabel = "Random by Button"
    }
    
    func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(randomView)
        randomView.addSubview(randomButton)
        
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
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomButtonTapped() {
        self.presenter.getRandom()
    }
}

extension RandomBeerVC: RandomView {
    func onItemsRetrieval(beers: [Beer]) {
        self.randomView.setupView(model: beers.first ?? Beer(id: 0, name: "", description: "", imageURL: ""))
    }
    
}
