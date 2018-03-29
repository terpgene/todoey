//
//  ViewController.swift
//  todoey
//
//  Created by Gene Essel on 3/24/18.
//  Copyright © 2018 Gene Essel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath)
        
        loadItems()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

 
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
       cell.accessoryType = item.done  ? .checkmark : .none

        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item to alert
            let newItem = Item()
            newItem.title = textfield.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textfield = alertTextfield
          
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItems() {
        let encorder = PropertyListEncoder()
        do{
            let data = try encorder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()

    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
                
            }catch {
                print("Error decoding files, \(error)")
            }
        }
    }
    
}

