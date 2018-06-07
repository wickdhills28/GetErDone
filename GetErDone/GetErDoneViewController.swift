//
//  ViewController.swift
//  GetErDone
//
//  Created by Steven Nguyen on 2018-06-06.
//  Copyright © 2018 Steven Nguyen. All rights reserved.
//

import UIKit

class GetErDoneViewController: UITableViewController {

    let itemArray = ["Wake Up", "Exercise","Shower", "Breakfast", "Chill + Music", "School Work", "Work", "Chillax"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        cell.textLabel?.text = itemArray[indexPath.row]   //Set the text in the cells
        
        return cell
        
    }

    //MARK - Table View Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])    // Prints number of cell selected
        
        
        // When cell is selected in app, Add a checkmark if not already there, if it does remove it
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
    
        
        tableView.deselectRow(at: indexPath, animated: true)    //Makes it so that the selected cell doesn't stay gray permanently
         
        
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

















