//
//  ItemDetailViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/24/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

//MARK: Add & Edit Item Protocols
protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController,didFinishAddingItem item: OwlistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: OwlistItem)
}

//MARK: Main Class Start
class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    //MARK: Interface Outlets
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    // This variable contains the existing ChecklistItem object that the user will be editing. 
    //But when adding a new to-do item, itemToEdit will be nil. 
    //That is how the view controller will make the distinction between adding and editing.
    
    var itemToEdit: OwlistItem?
    weak var delegate: ItemDetailViewControllerDelegate?
    
    //MARK: Button Functions
    @IBAction func cancel(sender: AnyObject) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: AnyObject) {
        if let item = itemToEdit
        {
            item.text = textField.text
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = OwlistItem()
            item.text = textField.text
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    //MARK: Table View Selection Methods
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    //MARK: View Controller Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: Text Field Delegate Methods
    // This is one of the UITextField delegate methods. It is invoked every time the user changes the text, whether by tapping on the keyboard or by cut/paste.
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
            replacementString string: String) -> Bool {
            let oldText: NSString =  textField.text
            let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
            doneBarButton.enabled = (newText.length > 0)
            return true
    }
}
