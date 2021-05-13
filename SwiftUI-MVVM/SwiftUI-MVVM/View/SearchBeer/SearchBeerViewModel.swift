//
//  SearchBeerViewModel.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Foundation

class SearchBeerViewModel: ObservableObject {
    @Published var beer = Beer(id: nil, name: "Please Search Beer By ID", description: nil, imageURL: nil)
    @Published var text = ""
    @Published var isEditing = false
    @Published var isLoading = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""
    
    let networkingApi: NetworkingService
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
    }
    
    func searchBeer() {
        self.isLoading = true
        networkingApi.request(.searchID(id: Int(text) ?? 0)) { result in
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
