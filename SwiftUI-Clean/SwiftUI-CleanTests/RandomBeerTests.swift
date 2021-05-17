//
//  RandomBeerTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import XCTest

@testable import SwiftUI_Clean

class RandomBeerTests: XCTestCase {
    var viewModel: RandomBeerViewModel!

    override func setUp() {
        viewModel = MockAppDI.shared.successRandomBeerViewModel()
    }

    func test_get_beer() {
        viewModel.apply(.getRandom)

        XCTAssertEqual(viewModel.beer, Bundle.getSingleBeerJson().first!)
    }

    func test_fail_network() {
        viewModel = MockAppDI.shared.failRandomBeerViewModel()
        viewModel.apply(.getRandom)

        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, "The operation couldn’t be completed. (SwiftUI_Clean.NetworkingError error 1.)")
    }
}
