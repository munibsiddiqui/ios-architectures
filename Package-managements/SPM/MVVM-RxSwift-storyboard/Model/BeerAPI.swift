//
//  BeerAPI.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import Foundation

enum BeerAPI {
    case getBeerList(page: Int)
    case getDetailBeer(id: Int)
    case searchID(id: Int)
    case random
}

extension BeerAPI {
    var baseURL: String {
        return "https://api.punkapi.com/v2/beers"
    }
    
    var path: String {
        switch self {
        case .random:
            return "/random"
        default:
            return ""
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var querys: [String: String]? {
        switch self {
        case let .getBeerList(page):
            return ["page": String(page)]
        case let .searchID(id):
            return ["ids": String(id)]
        case let .getDetailBeer(id):
            return ["ids": String(id)]
        case .random:
            return nil
        }
    }
}
