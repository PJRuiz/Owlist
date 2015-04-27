//
//  AllListsViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/25/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Initializer with NSCoder
    var dataModel: DataModel!
    weak var delegate: ListDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        let owlist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = owlist.name
        cell.accessoryType = .DetailDisclosureButton
        
        let count = owlist.countUncheckedItems()
        if owlist.items.count == 0
            {
                cell.detailTextLabel!.text = "(No Items)"
            } else if count == 0
            {
                cell.detailTextLabel!.text = "All Done!"
            } else
            {
                cell.detailTextLabel!.text = "\(count) Remaining"
            }
        cell.imageView!.image = UIImage(named: owlist.iconName)
        return cell
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedOwlist = indexPath.row
        let owlist = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowOwlist", sender: owlist)
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            dataModel.lists.removeAtIndex(indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        
        let owlist = dataModel.lists[indexPath.row]
        controller.owlistToEdit = owlist
        
        presentViewController(navigationController, animated: true, completion: nil)
    }

    
    //MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowOwlist" {
            let controller = segue.destinationViewController as! OwlistViewController
            controller.owlist = sender as! Owlist
        } else if segue.identifier == "AddOwlist"
        {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! ListDetailViewController
                controller.delegate = self
                controller.owlistToEdit = nil
        }
    }
    
    //MARK: - List Detail View Controller Methods
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
                    dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingOwlist owlist: Owlist) {
            dataModel.lists.append(owlist)
            dataModel.sortOwlists()
            tableView.reloadData()
            dismissViewControllerAnimated(true, completion: nil)
     }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingOwlist owlist: Owlist) {
                dataModel.sortOwlists()
                tableView.reloadData()
                dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: -Reset to Main Index if you exit an Owlist
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController,
        animated: Bool) {
        if viewController === self
        {
            dataModel.indexOfSelectedOwlist = -1
        }
    }
    
    //MARK: -View Appear Methods
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) { super.viewDidAppear(animated)
            navigationController?.delegate = self
            let index = dataModel.indexOfSelectedOwlist
            if index >= 0 && index < dataModel.lists.count
            {
                    let owlist = dataModel.lists[index]
                    performSegueWithIdentifier("ShowOwlist", sender: owlist)
            }
    }
    
     //MARK: - Final Class Closure
}