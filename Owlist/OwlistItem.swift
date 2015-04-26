//
//  OwlistItem.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/24/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import Foundation


class OwlistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    //MARK: NSCoder Methods
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
}