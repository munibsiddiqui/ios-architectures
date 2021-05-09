//
//  BeerStep.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/05/09.
//

import RxFlow

enum BeerStep: Step {
    // Global
    case alert(String)
    
    // TabBar
    case TabBarIsRequired

    // Beer List
    case BeerListIsRequired
    case BeerDetailIsPicked (beer: Beer)

    // Search Beer
    case SearchBeerIsRequired

    // Random Beer
    case RandomBeerIsRequired
}
