//
//  BeerListSection.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import Foundation
import RxDataSources

struct BeerListSection {
  let header: String
  var items: [Beer]
}

extension BeerListSection: SectionModelType {
  init(original: BeerListSection, items: [Beer]) {
    self = original
    self.items = items
  }
}
