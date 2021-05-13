//
//  RandomBeerViewModel.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation

class RandomBeerViewModel: ObservableObject {
    @Published var beer = Beer(id: nil, name: "Loading...", description: nil, imageURL: nil)
    @Published var isLoading = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
    }
    
    func getrandomBeer() {
        self.isLoading = true
        networkingApi.request(.random) { result in
            switch result {
            case let .success(beers):
                if !beers.isEmpty { self.beer = beers.first! }
            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.isErrorAlert = true
            }
        }
        self.isLoading = false
    }
}
