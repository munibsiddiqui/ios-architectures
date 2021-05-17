//
//  SearchBeerTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import XCTest

@testable import SwiftUI_Clean

class SearchBeerTests: XCTestCase {
    var viewModel: SearchBeerViewModel!

    override func setUp() {
        viewModel = MockAppDI.shared.successSearchBeerViewModel()
    }

    func test_get_beer() {
        viewModel.text = "1"
        viewModel.apply(.search)

        XCTAssertEqual(viewModel.beer, Bundle.getSingleBeerJson().first!)
    }

    func test_fail_network() {
        viewModel = MockAppDI.shared.failSearchBeerViewModel()
        viewModel.text = "1"
        viewModel.apply(.search)

        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, "The operation couldn’t be completed. (SwiftUI_Clean.NetworkingError error 1.)")
    }
}
