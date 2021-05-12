//
//  Rx+ViewDidLoad.swift
//  MVVM-RxSwift-snapKit
//
//  Created by GoEun Jeong on 2021/04/29.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
  var viewDidLoad: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
    return ControlEvent(events: source)
  }
}
