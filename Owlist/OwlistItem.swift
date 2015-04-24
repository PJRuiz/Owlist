//
//  OwlistItem.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/24/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import Foundation


class OwlistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}