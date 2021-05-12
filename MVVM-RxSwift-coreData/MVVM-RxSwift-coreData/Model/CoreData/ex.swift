//
//  ex.swift
//  MVVM-RxSwift-coreData
//
//  Created by GoEun Jeong on 2021/05/11.
//

import Foundation

import CoreData

public extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
