//
//  BeerView.swift
//  MVC-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import UIKit
import SnapKit
import Kingfisher

class BeerView: UIView {
    private let stackSpacing: CGFloat = 10.0
    private let padding: CGFloat = 16.0

    private lazy var beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints {
            $0.height.width.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        return beerImageView
    }()

    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.text = ""
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return idLabel
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Please Search Beer by ID"
        return nameLabel
    }()

    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = ""
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 0
        return descLabel
    }()

    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [beerImageView, idLabel, nameLabel, descLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .center
        nameStackView.spacing = stackSpacing
        return nameStackView
    }()

    // MARK: - Initialization
    
    override func draw(_ rect: CGRect) {
        setupSubview()
    }

    // MARK: - Public Methods
    
    func setupView(model: Beer) {
        DispatchQueue.main.async { // Change UI
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descLabel.text = model.description ?? ""
        }
    }

    // MARK: Private Methods
    
    private func setupSubview() {
        addSubview(nameStackView)
        nameStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(padding)
        }
    }
}
