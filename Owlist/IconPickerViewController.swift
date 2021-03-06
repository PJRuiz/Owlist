//
//  IconPickerViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/27/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickerViewController,didPickIcon iconName: String)
}

class IconPickerViewController: UITableViewController {
        weak var delegate: IconPickerViewControllerDelegate?
        
        let icons = [
                            "No Icon", "Reading",
                            "Appointments",
                            "Birthdays",
                            "Chores",
                            "Work",
                            "Groceries",
                            "Trips",
                            "Pets", "Programming"
                        ]
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                                return icons.count
        }
        
        override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("IconCell") as! UITableViewCell
            let iconName = icons[indexPath.row]
            cell.textLabel!.text = iconName
            cell.imageView!.image = UIImage(named: iconName)
            return cell
        }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPickIcon: iconName)
        }
    }
        
}