//
//  SearchBeerView.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/12.
//

import SwiftUI

struct SearchBeerView: View {
    @State var beer = Beer(id: nil, name: "Please Search Beer By ID", description: nil, imageURL: nil)
    @State private var text = ""
    @State private var isEditing = false
    @State var isLoading = false
    @State var isErrorAlert = false
    @State var errorMessage = ""
    
    let networkingApi = NetworkingAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                
                // MARK: - Search Bar
                HStack {
                    TextField("Search ...", text: $text, onCommit: {
                        self.searchBeer(id: Int(text) ?? 0)
                    })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.text = ""
                            
                            // Dismiss the keyboard
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Text("Cancel")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
                ZStack {
                    VStack {
                        SingleBeerView(beer: $beer)
                        Spacer()
                    }
                    ActivityIndicator(isAnimating: $isLoading, style: .large)
                }
                
            }.navigationBarTitle("Search By ID", displayMode: .large)
        }
    }
    
    func searchBeer(id: Int) {
        self.isLoading = true
        networkingApi.request(.searchID(id: id)) { result in
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

struct SearchBeerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeerView(beer: Bundle.getSingleBeerJson().first!)
    }
}
