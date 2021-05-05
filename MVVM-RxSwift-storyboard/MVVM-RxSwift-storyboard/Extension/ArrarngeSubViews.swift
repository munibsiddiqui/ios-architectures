//
//  ArrarngeSubViews.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
