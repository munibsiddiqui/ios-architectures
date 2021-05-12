//
//  ArrangeSubviews.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
