//
//  Category.swift
//  todoey
//
//  Created by Gene Essel on 4/14/18.
//  Copyright © 2018 Gene Essel. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
