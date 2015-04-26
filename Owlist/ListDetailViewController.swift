//
//  ListDetailViewController.swift
//  Owlist
//
//  Created by Pedro Ruíz on 4/25/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import UIKit

//MARK: Add & Edit List Protocols
protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController,didFinishAddingOwlist owlist: Owlist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingOwlist owlist: Owlist)
}


class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    //MARK: -IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var owlistToEdit: Owlist?
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        if let owlist = owlistToEdit {
            title = "Edit Owklist"
            textField.text = owlist.name
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            textField.becomeFirstResponder()
    }
    
    //MARK: -IBAction for Buttons
    
    @IBAction func cancel() {
            delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
                if let owlist = owlistToEdit {
                    owlist.name = textField.text
                    delegate?.listDetailViewController(self,didFinishEditingOwlist: owlist)
                } else {
                    let owlist = Owlist(name: textField.text)
                    delegate?.listDetailViewController(self, didFinishAddingOwlist: owlist)
                }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
                        let oldText: NSString = textField.text
                        let newText: NSString = oldText.stringByReplacingCharactersInRange( range, withString: string)
                        doneBarButton.enabled = (newText.length > 0)
                        return true
    }
    
    
    
    //MARK: Final Closure
}
