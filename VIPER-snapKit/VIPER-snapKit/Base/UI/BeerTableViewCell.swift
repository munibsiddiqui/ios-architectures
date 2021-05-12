//
//  BeerTableViewCell.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit
import SnapKit
import Then
import Kingfisher

struct Padding {
    static let stackSpacing: CGFloat = 10.0
    static let padding: CGFloat = 16.0
}

class BeerTableViewCell: UITableViewCell {
    private let beerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
    }
    
    private let idLabel = UILabel().then {
        $0.textColor = UIColor.orange
        $0.text = "ID"
        $0.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "User Name"
    }
    
    private let descLabel = UILabel().then {
        $0.text = "Description"
        $0.textColor = UIColor.gray
        $0.numberOfLines = 3
    }
    
    private let nameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .top
    }
    
    private let mainStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = Padding.stackSpacing
    }
    
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
        DispatchQueue.main.async {
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descLabel.text = model.description ?? ""
        }
    }
    
    // MARK: Private Methods
    
    private func setupSubview() {
        addSubview(mainStackView)
        nameStackView.addArrangeSubviews([idLabel, nameLabel, descLabel])
        mainStackView.addArrangeSubviews([beerImageView, nameStackView])
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Padding.padding)
            $0.bottom.equalToSuperview().inset(Padding.padding).priority(.high)
        }
    }
}
