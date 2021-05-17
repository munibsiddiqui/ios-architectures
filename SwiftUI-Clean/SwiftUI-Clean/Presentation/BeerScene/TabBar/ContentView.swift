//
//  ContentView.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AppDI.shared.getBeerListView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Beer List")
                }
            AppDI.shared.getSearchBeerView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Search ID")
                }

            AppDI.shared.getRandomBeerView()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Random")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
