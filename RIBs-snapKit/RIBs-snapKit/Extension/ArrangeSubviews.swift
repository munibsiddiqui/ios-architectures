//
//  ArrangeSubviews.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangeSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
