//
//  RandomBeerView.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/12.
//

import SwiftUI

struct RandomBeerView: View {
    @State var beer = Beer(id: nil, name: "Loading...", description: nil, imageURL: nil)
    @State var isLoading = false
    @State var isErrorAlert = false
    @State var errorMessage = ""
    
    let networkingApi = NetworkingAPI()
    
    var body: some View {
        NavigationView {
            ZStack {
                SingleBeerView(beer: $beer)
                VStack {
                    Button(action: {
                        self.getrandomBeer()
                    }) {
                        VStack {
                            Text("Roll Random")
                                .foregroundColor(.white)
                                .background(Rectangle().foregroundColor(.orange).frame(width: UIFrame.UIWidth - 100, height: 40))
                        }
                    }.padding(.top, UIFrame.UIHeight / 1.5)
                }
                ActivityIndicator(isAnimating: $isLoading, style: .large)
            }.navigationBarTitle("Random Beer", displayMode: .large)
        }.onAppear() {
            self.getrandomBeer()
        }
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

struct RandomBeerView_Previews: PreviewProvider {
    static var previews: some View {
        RandomBeerView(beer: Bundle.getSingleBeerJson().first!)
    }
}
