//
//  BeerTableViewCell.swift
//  JGE-Beer
//
//  Created by GoEun Jeong on 2021/03/26.
//

import UIKit
import SnapKit
import Kingfisher

class BeerTableViewCell: UITableViewCell {
    private let stackSpacing: CGFloat = 10.0
    private let padding: CGFloat = 16.0
    
    private lazy var beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
        return beerImageView
    }()
    
    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.text = "ID"
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return idLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "User Name"
        return nameLabel
    }()
    
    private lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Description"
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 3
        return descLabel
    }()
    
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .top
        return nameStackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView(arrangedSubviews: [beerImageView, nameStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = stackSpacing
        return mainStackView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(padding)
            $0.bottom.equalToSuperview().inset(padding).priority(.high)
        }
    }
}
