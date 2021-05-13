//
//  BeerListTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import XCTest

@testable import SwiftUI_MVVM

class BeerListTests: XCTestCase {
    var viewModel: BeerListViewModel!

    override func setUp() {
        viewModel = BeerListViewModel(networkingApi: MockNetworkingAPI())
    }
    
    func test_get_beer() {
        viewModel.onAppear()
        
        XCTAssertEqual(viewModel.beers, Bundle.getBeerListJson())
    }
    
    func test_fail_network() {
        viewModel = BeerListViewModel(networkingApi: FailedNetworkingAPI())
        viewModel.onAppear()
        
        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, FailedError.noInternet.errorMessage)
    }
}
