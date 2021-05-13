//
//  SearchBeerTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import XCTest

@testable import SwiftUI_MVVM

class SearchBeerTests: XCTestCase {
    var viewModel: SearchBeerViewModel!

    override func setUp() {
        viewModel = SearchBeerViewModel(networkingApi: MockNetworkingAPI())
    }
    
    func test_get_beer() {
        viewModel.text = "1"
        viewModel.searchBeer()
        
        XCTAssertEqual(viewModel.beer, Bundle.getSingleBeerJson().first!)
    }
    
    func test_fail_network() {
        viewModel = SearchBeerViewModel(networkingApi: FailedNetworkingAPI())
        viewModel.text = "1"
        viewModel.searchBeer()
        
        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, FailedError.noInternet.errorMessage)
    }
}
