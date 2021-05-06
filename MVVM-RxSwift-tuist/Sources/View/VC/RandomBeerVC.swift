//
//  RandomBeerVC.swift
//  MVC-storyboard
//
//  Created by GoEun Jeong on 2021/04/28.
//

import UIKit
import RxSwift
import RxCocoa

class RandomBeerVC: UIViewController {
    @IBOutlet private weak var beerImageView: UIImageView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    
    private let activityIndicator = UIActivityIndicatorView()
    private let disposeBag = DisposeBag()
    private let viewModel = RandomBeerViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        bindViewModel()
    }
    
    private func setupSubview() {
        view.addSubview(activityIndicator)
    }
    
    private func setupView(model: Beer) {
        DispatchQueue.main.async {
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descLabel.text = model.description ?? ""
        }
    }
    
    private func bindViewModel() {
        Observable.just(())
            .bind(to: viewModel.input.buttonTrigger)
            .disposed(by: disposeBag)

        viewModel.output.beer
            .subscribe(onNext: { [weak self] beer in
                self?.setupView(model: beer.first ?? Beer(id: nil, name: "Loading...", description: "", imageURL: ""))
            })
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.output.errorRelay
            .subscribe(onNext: { [weak self] error in
                self?.showErrorAlert(with: error.message)
            }).disposed(by: disposeBag)
    }
    
    @IBAction private func rarndomButtonClicked(_ sender: Any) {
        viewModel.input.buttonTrigger.accept(())
    }
}
