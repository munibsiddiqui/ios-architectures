//
//  Bundle+Ex.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/12.
//

import Foundation

extension Bundle {
    static func getBeerListJson() -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        
        return bundle!.decode([Beer].self, from: "BeerList.json")
    }
    static func getSingleBeerJson() -> [Beer] {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        
        return bundle!.decode([Beer].self, from: "SingleBeer.json")
    }
}
