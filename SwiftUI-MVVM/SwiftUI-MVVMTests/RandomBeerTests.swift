//
//  RandomBeerTests.swift
//  SwiftUI-MVVMTests
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation
import XCTest

@testable import SwiftUI_MVVM

class RandomBeerTests: XCTestCase {
    var viewModel: RandomBeerViewModel!

    override func setUp() {
        viewModel = RandomBeerViewModel(networkingApi: MockNetworkingAPI())
    }
    
    func test_get_beer() {
        viewModel.getrandomBeer()
        
        XCTAssertEqual(viewModel.beer, Bundle.getSingleBeerJson().first!)
    }
    
    func test_fail_network() {
        viewModel = RandomBeerViewModel(networkingApi: FailedNetworkingAPI())
        viewModel.getrandomBeer()
        
        XCTAssertEqual(viewModel.isErrorAlert, true)
        XCTAssertEqual(viewModel.errorMessage, FailedError.noInternet.errorMessage)
    }
}
