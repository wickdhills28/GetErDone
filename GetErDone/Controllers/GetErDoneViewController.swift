//
//  ViewController.swift
//  GetErDone
//
//  Created by Steven Nguyen on 2018-06-06.
//  Copyright © 2018 Steven Nguyen. All rights reserved.
//

import UIKit

class GetErDoneViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard  //Create a UserDefaults object, interface to user's default's database, set as standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
                                                                //THIS IS HOW YOU PROPERLY CAST, USE 'as' KEYWORD!!!
        if let items = defaults.array(forKey: "GetErDoneArray") as? [Item]{
                itemArray = items   // If an array exists in the user defaults, set itemArray to that array
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Create Table View Data Source methods
    
    //Determine Number of rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //Create the cells for the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create the cell and links with cell identifier in main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetErDoneCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].task   //Set the text in the cells
        
        // Ternary operator =>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none     // using ternary operator   
        
        return cell
        
    }

    //MARK - Table View Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])    // Prints number of cell selected
        

            itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Switch to opposite once tapped
       
        
        tableView.reloadData()  // Reload the data to update the checkmarks; forces calls to ALL tableView() methods
        
        // When cell is selected in app, Add a checkmark if not already there, if it does remove it
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    
        
        tableView.deselectRow(at: indexPath, animated: true)    //Makes it so that the selected cell doesn't stay gray permanently
        
    }
    
    //MARK - Add new items section
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //Alert will need an action added to it
        var textField : UITextField = UITextField()
        
        
        let alert = UIAlertController(title: "AddEr A New Item", message: "", preferredStyle: .alert)
    
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen when user clicks "Add Item" button on our UIAlert
            print(textField.text!)
            
            //Create new item, add the task to it and append it to the itemArray of Item objects
            let newItem = Item()
            newItem.task = textField.text!
            self.itemArray.append(newItem)       // Add to item array
            
            // Save updated itemArray to our user defaults, then use it to load up table view when we start app again
            self.defaults.set(self.itemArray, forKey: "GetErDoneArray")
            
            // ---- IMPORTANT FOR UI
            self.tableView.reloadData() //Updates tableview when new item has been added
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enter new item" //Placeholder for when the text field first shows, it will turn white when user clicks on it
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        // This method must be called to display the alert to the user
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
















