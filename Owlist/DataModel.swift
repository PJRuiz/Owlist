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
    
    //MARK: -Initializers
    init( ) {
        loadOwlists( )
        registerDefaults( )
        handleFirstTime()
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
                sortOwlists()
            }
        }
    }
    
    //MARK: - Default Values for NSUserDefaults
    func registerDefaults() {
            let dictionary = [ "OwlistIndex": -1, "FirstTime": true, "OwlistItemID": 0 ]
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
    
    //MARK: -First Time Launching App
    func handleFirstTime() {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                let firstTime = userDefaults.boolForKey("FirstTime")
                if firstTime {
                    let owlist = Owlist(name: "List")
                    lists.append(owlist)
                    indexOfSelectedOwlist = 0
                    userDefaults.setBool(false, forKey: "FirstTime")
                }
    }
    
    //MARK: - Sort Owlists
    func sortOwlists() {
                lists.sort({
                owlist1, owlist2 in return
                owlist1.name.localizedStandardCompare(owlist2.name) == NSComparisonResult.OrderedAscending
                })
    }
    
    //MARK: - Notifications
    class func nextOwlistItemID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemID = userDefaults.integerForKey("OwlistItemID")
        userDefaults.setInteger(itemID + 1, forKey: "OwlistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    //MARK: -FInal Closure
}