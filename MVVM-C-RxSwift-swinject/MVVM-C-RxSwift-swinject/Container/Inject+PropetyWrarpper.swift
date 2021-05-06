//
//  Inject+PropetyWrarpper.swift
//  MVVM-C-RxSwift-swinject
//
//  Created by GoEun Jeong on 2021/05/06.
//

import Foundation

@propertyWrapper
class Inject<T> {
    
    let wrappedValue: T
    
    init() {
        self.wrappedValue = AppDelegate.container.resolve(T.self)!
    }
}
