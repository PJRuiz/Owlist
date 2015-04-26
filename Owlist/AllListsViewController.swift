//
//  AllListsViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/25/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    //MARK: - Initializer with NSCoder
    required init(coder aDecoder: NSCoder) {
        
        lists = [Owlist]( )
        
        super.init(coder: aDecoder)
        var list = Owlist(name: "Birthdays")
        lists.append(list)
        
        list = Owlist(name: "Groceries")
        lists.append(list)
        list = Owlist(name: "Cool Apps")
        lists.append(list)
        list = Owlist(name: "To Do")
        lists.append(list)
    }

    
    var lists: [Owlist]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        let owlist = lists[indexPath.row]
        cell.textLabel!.text = owlist.name
        cell.accessoryType = .DetailDisclosureButton
        
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let owlist = lists[indexPath.row]
        performSegueWithIdentifier("ShowOwlist", sender: owlist)
        
    }
    
    //MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowOwlist" {
            let controller = segue.destinationViewController as! OwlistViewController
            controller.owlist = sender as! Owlist
        } else if segue.identifier == "AddOwlist" {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! ListDetailViewController
                controller.delegate = self
                controller.owlistToEdit = nil }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
                    dismissViewControllerAnimated(true, completion: nil)
                    println("Pressed Cancel")
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingOwlist owlist: Owlist) {
            let newRowIndex = lists.count
            lists.append(owlist)
            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
            let indexPaths = [indexPath]
            tableView.insertRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
            dismissViewControllerAnimated(true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingOwlist owlist: Owlist) {
        if let index = find(lists, owlist) {
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(indexPath)
            {
                cell.textLabel!.text = owlist.name }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView,
                commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
                lists.removeAtIndex(indexPath.row)
                let indexPaths = [indexPath]
                tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        
        let owlist = lists[indexPath.row]
        controller.owlistToEdit = owlist
        
        presentViewController(navigationController, animated: true, completion: nil)
    }

    
    //MARK: - Final Class Closure
}
