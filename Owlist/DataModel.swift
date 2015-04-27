//
//  DataModel.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/27/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Owlist]()
    init( ) {
        loadOwlists( )
        registerDefaults( )
    }
    
    //MARK: -Load & Save
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true) as! [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
            return documentsDirectory().stringByAppendingPathComponent("Owlists.plist")
    }
    
    func saveOwlists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Owlists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadOwlists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Owlists") as! [Owlist]
                unarchiver.finishDecoding()
            }
        }
    }
    
    //MARK: - Default Values for NSUserDefaults
    func registerDefaults() {
            let dictionary = [ "OwlistIndex": -1, "FirstTime": true ]
            NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    var indexOfSelectedOwlist: Int {
        get
        {
            return NSUserDefaults.standardUserDefaults().integerForKey( "OwlistIndex")
        }
        
        set
        {
            NSUserDefaults.standardUserDefaults().setInteger(newValue,forKey: "OwlistIndex")
        }
    }
    
    //MARK: -FInal Closure
}