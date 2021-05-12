//
//  Inject+PropertyWrapper.swift
//  Clean-RxFlow-Swinject
//
//  Created by GoEun Jeong on 2021/05/11.
//

import Foundation

@propertyWrapper
class Inject<T> {
    
    let wrappedValue: T
    
    init() {
        self.wrappedValue = AppDelegate.container.resolve(T.self)!
    }
}
