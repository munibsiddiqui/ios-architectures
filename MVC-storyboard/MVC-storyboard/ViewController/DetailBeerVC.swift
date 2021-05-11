//
//  DetailVC.swift
//  MVC-storyboard
//
//  Created by GoEun Jeong on 2021/05/01.
//

import UIKit

class DetailBeerVC: UIViewController {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var beer: Beer!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView(model: beer)
    }
    
    private func setupView(model: Beer) {
        DispatchQueue.main.async {
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descLabel.text = model.description ?? ""
        }
    }
    
}
