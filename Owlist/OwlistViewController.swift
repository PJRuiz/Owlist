//
//  ViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/23/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class OwlistViewController: UITableViewController {
    
    //MARK: Dummy Variables
    // This declares that items will hold an array of ChecklistItem objects 
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    
    var items: [OwlistItem]
    
    //MARK: Initializer for Checklist Items
    required init(coder aDecoder: NSCoder) {
        
        // This instantiates the array. Now items contains a valid array object, // but the array has no ChecklistItem objects inside it yet.
        items = [OwlistItem]()
        
        let row0item = OwlistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = OwlistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
       let  row2item = OwlistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)

        let row3item = OwlistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)

        let row4item = OwlistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        let row5item = OwlistItem()
        row5item.text = "Bake a Cake"
        row5item.checked = true
        items.append(row5item)

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Data Source Protocol
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("OwlistItem") as! UITableViewCell
        
            let item = items[indexPath.row]
            configureTextForCell(cell, withOwlistItem: item)
            configureCheckmarkForCell(cell, withOwlistItem: item)
            return cell
    }
    
        //MARK: Checkmark Toggling
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                let item = items[indexPath.row]
                item.toggleChecked()
                configureCheckmarkForCell(cell, withOwlistItem: item)
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //MARK: Configure Checkmark
    func configureCheckmarkForCell(cell: UITableViewCell, withOwlistItem item: OwlistItem) {
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withOwlistItem item: OwlistItem)
                {
                        let label = cell.viewWithTag(1000) as! UILabel
                        label.text = item.text
                }
                
    //MARK: FInal Closure
}

