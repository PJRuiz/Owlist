//
//  Owlist.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/25/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class Owlist: NSObject, NSCoding {
   var name = ""
    var items = [OwlistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [OwlistItem]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(name, forKey: "Name")
            aCoder.encodeObject(items, forKey: "Items")
    }
    
    func countUncheckedItems() -> Int {
        return reduce(items, 0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
    
}
