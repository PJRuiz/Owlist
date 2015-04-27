//
//  ViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/23/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class OwlistViewController: UITableViewController, ItemDetailViewControllerDelegate {
        
    
    //MARK: Dummy Variables
    // This declares that items will hold an array of ChecklistItem objects 
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    
//    var items: [OwlistItem]
    var owlist: Owlist!
    
    //MARK: Initializer for Checklist Items
//    required init(coder aDecoder: NSCoder) {
////        items = [OwlistItem]()
//        super.init(coder: aDecoder)
//        loadOwlistItems()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        title = owlist.name
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Data Source Protocol
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return owlist.items.count
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("OwlistItem") as! UITableViewCell
        
            let item = owlist.items[indexPath.row]
            configureTextForCell(cell, withOwlistItem: item)
            configureCheckmarkForCell(cell, withOwlistItem: item)
            return cell
    }
    
    //MARK: Delete Rows (Swipe to Delete)
    override func tableView(tableView: UITableView,commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
                // remove the item from the data model,
                owlist.items.removeAtIndex(indexPath.row)
                // delete the corresponding row from the table view.
                let indexPaths = [indexPath]
                tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    
        //MARK: Checkmark Toggling
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                let item = owlist.items[indexPath.row]
                item.toggleChecked()
                configureCheckmarkForCell(cell, withOwlistItem: item)
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //MARK: Configure Checkmark
    func configureCheckmarkForCell(cell: UITableViewCell, withOwlistItem item: OwlistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✓"
        } else {
            label.text = ""
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withOwlistItem item: OwlistItem)
                {
                        let label = cell.viewWithTag(1000) as! UILabel
                        label.text = item.text
                }
    
    //MARK: AddItem View Controller Delegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
                dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: OwlistItem) {
                    let newRowIndex = owlist.items.count
                    owlist.items.append(item)
                    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
                    let indexPaths = [indexPath]
                    tableView.insertRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
                    dismissViewControllerAnimated(true, completion: nil)

    }
    
    //MARK: Editing Item View Controller Delegate
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: OwlistItem)
    {
            if let index = find(owlist.items, item)
            {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath)
                {
                    configureTextForCell(cell, withOwlistItem: item)
                }
            }
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem"
        {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
                        {
                            controller.itemToEdit = owlist.items[indexPath.row]
                        }
        }
    }
    //MARK: FInal Closure
}

