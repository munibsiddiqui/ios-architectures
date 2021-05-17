//
//  BeerListTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import Moya
import XCTest

@testable import SwiftUI_Clean

class BeerListTests: XCTestCase {
    var viewModel: BeerListViewModel!

    override func setUp() {
        viewModel = MockAppDI.shared.successBeerListViewModel()
    }

    func test_get_beer() {
        viewModel.apply(.getBeerList)
        
        XCTAssertEqual(viewModel.beers, Bundle.getBeerListJson())
    }

    func test_fail_network() {
        viewModel = MockAppDI.shared.failBeerListViewModel()
        viewModel.apply(.getBeerList)

        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, "The operation couldn’t be completed. (SwiftUI_Clean.NetworkingError error 1.)")
    }
}
