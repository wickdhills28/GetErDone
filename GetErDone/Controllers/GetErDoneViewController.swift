//
//  ViewController.swift
//  GetErDone
//
//  Created by Steven Nguyen on 2018-06-06.
//  Copyright © 2018 Steven Nguyen. All rights reserved.
//

import UIKit
import CoreData

class GetErDoneViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        
        //Everything between curly braces happens when selectedCategory is set with a value
        didSet{
            loadItems()
        }
    }
    
    
//    let defaults = UserDefaults.standard  //Create a UserDefaults object, interface to user's default's database, set as standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext   //Get context

    
    // USING CODABLE ===============
    //REMINDER:  .default is a Singleton! This singleton contains a ton of URLs organized by directory and domain mask
    // URLs lead to data stored
    // .first because it is an array and we want to grab the first item
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    // USING CODABLE ===============
    
    
    // *** USE THIS TO GET PATH TO WHERE OUR DATA IS BEING STORED:  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        print(dataFilePath!)    //Prints out the file path to a plist that holds our NS user defaults
        
        
        // USING CODABLE ===============
//        loadItems() //Loads/decodes NSCoder data USING ENCODER/DECODER
        // USING CODABLE ===============

        //====== USING USER DEFAULTS ======
        //THIS IS HOW YOU PROPERLY CAST, USE 'as' KEYWORD!!!
//        if let items = defaults.array(forKey: "GetErDoneArray") as? [Item]{
//                itemArray = items   // If an array exists in the user defaults, set itemArray to that array
//        }
        
        // searchBar.delegate = self //You can do this or ctrl+drag search bar to yellow dot
                //White dot beside "delegate" when dragged will indicate that the bar has a delegate
        
        //        loadItems() //Load items from Core Data; Not needed if using categories because we want to make sure a category is set before we load or else nothing can be loaded and we'll have an error
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Create Table View Data Source methods
    
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

    //MARK: - Table View Delegates
    
    // Deals with when user selects/taps on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        // USING DELETE INSTEAD OF CHECKMARKS TO INDICATE "DONE" ==============
//        context.delete(itemArray[indexPath.row])    // Tells our core data that something has been deleted
//        itemArray.remove(at: indexPath.row) //Only updates our itemArray, must be called after the context or else indexing error
        // USING DELETE INSTEAD OF CHECKMARKS TO INDICATE "DONE" ==============

        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Switch to opposite once tapped
        
        saveItems() //Saves the "current" context to persistent container, IMPORTANT
        
        tableView.reloadData()  // Reload the data to update the checkmarks; forces calls to ALL tableView() methods

        
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
            
            let newItem = Item(context:self.context)
            newItem.task = textField.text!  //Update task property
            newItem.done = false    // Initialize the done property
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)       // Add to item array
            
            // Save updated itemArray to our user defaults, then use it to load up table view when we start app again
//            self.defaults.set(self.itemArray, forKey: "GetErDoneArray")
            
            
            self.saveItems()
            
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
    
    
    // Saves data into NSCoder, convert data to plist
    func saveItems(){
        
        //USING ENCORDER code to encode item array ================== plist created
//        let encoder = PropertyListEncoder()
//        do{
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//        }catch{
//            print("Error encoding item array, \(error)")
//        }
        //USING ENCORDER code to encode item array ================== plist created

        do{
            try context.save()
        }catch{
            print("@@@ Error saving context \(error)")
        }
        
        
        
        
    }
    
    // Retrieve the data from plist and covert into useable data for app
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil ){
    // loadItems method contains: External+Internal parameter + Default value given to param if no args are passed^^^
    // predicate parameter has an optional (?) because it can be nil, we can have no predicates, sometimes we want to load all the data
        
        //USING DECODER =============
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch{
//                    print("Error decoding item array, \(error)")
//            }
//        }
        //USING DECODER =============
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()    //In this case, datatype must be specified ( NSFetchRequest<Item>)
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        //Using optional binding so that we don't unwrap a nil value
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            //Allows for more than 1 predicate when doing a query
            
        }else{
            request.predicate = categoryPredicate   //Set the predicate of the request to get the data under the category(no predicates from search bar)
        }
        
        
        do{
            itemArray = try context.fetch(request) //Try to set the itemArray to the data stored
        }catch{
            print("@@@ Error fetching data from context \(error)")
        }
        
        tableView.reloadData()  //Reloads data after being fetched

    }
    

}


//MARK: Search Bar Methods
//using the 'extension' keyword makes it easier to navigate through class when debugging long code
// Good for organization
extension GetErDoneViewController: UISearchBarDelegate{
    // Everything in here adds to the GerErDoneViewController class
    // Extension groups protocol methods together
    
    
    // Used to query database to get what user is searching for
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        // NSPredicate does the querying-> Search for whatever the user typed into the search bar
        let predicate  = NSPredicate(format: "task CONTAINS %@", searchBar.text!)//Set the predicate of the request
        // Get the 'task's that contain whatever was entered
        //View NSPredicate CheatSheet on Google; CONTAINS is similar to sql in cmpt 260
        // NSPredicate is basically a query language, specifies how data should be fetched or filtered
        // Regex is sort of a query language - how data should be fetched/filtered
        
        let sortDescriptor = NSSortDescriptor(key: "task", ascending: true) //Sorts the data queried
        request.sortDescriptors = [sortDescriptor]    //Add sort discriptor or our NSfetchrequest; array is expected but tutorial sets it to just one item
        
        // Set parameters for what you want to request (ex. predicate, sortdescriptor, etc.)^^^
        
        //Fetch data from context using the request created above
        loadItems(with: request,predicate: predicate)
    }
    
    
    // Called ONLY when contents of search bar changes
    // Delegate methods are automatically called while user uses the app
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            // Ask DispatchQueue for main thread to dismiss our search bar on the main thread even if background threads are still going
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()    //Gets rid of search bar cursor and keyboard from screen because we want to exit the search

            }
        }
    }
    
    
}
    


















