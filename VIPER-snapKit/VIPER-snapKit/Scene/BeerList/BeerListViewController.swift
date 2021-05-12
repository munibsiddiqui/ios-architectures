//
//  BeerListViewController.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//  
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class BeerListViewController: UIViewController, BeerListViewProtocol {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let disposeBag = DisposeBag()
    let presenter: BeerListPresenter
    
    // MARK: - Table View
    
    private let dataSource = RxTableViewSectionedReloadDataSource<BeerListSection>(configureCell: {  (_, tableView, _, beer) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell") as? BeerTableViewCell ?? BeerTableViewCell(style: .default, reuseIdentifier: "BeerTableViewCell")
        cell.setupView(model: beer)
        return cell
    })
    
    // MARK: - Initialization
    
    init(presenter: BeerListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.bindPresenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
    }
    
    // MARK: - Private Methods
    
    private func setupSubview() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "BeerList"
        self.navigationItem.accessibilityLabel = "BeerList"
    }
    
    private func bindPresenter() {
        self.rx.viewDidLoad
            .bind(to: presenter.input.viewDidLoad)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: presenter.input.refreshTrigger)
            .disposed(by: disposeBag)
        
        presenter.output.list
            .map { [BeerListSection(header: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        presenter.output.isLoading
            .filter { !$0 }
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        presenter.output.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Beer.self)
            .bind(to: presenter.input.detailBeerTrigger)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { self.tableView.deselectRow(at: $0, animated: true)})
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom(offset: 120.0)
            .bind(to: presenter.input.nextPageTrigger)
            .disposed(by: disposeBag)
    }
}
