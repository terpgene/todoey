//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Gene Essel on 4/3/18.
//  Copyright © 2018 Gene Essel. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryTableViewController: SwipeTableViewController {
    
    
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

            loadCategories()
        
            tableView.separatorStyle = .none
  
    }
    
    //MARK: - Tabliev Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        if let category = categories?[indexPath.row] {
        
            cell.backgroundColor = UIColor(hexString: category.color )
        
            cell.textLabel?.text = category.name 
        }
        return cell
    }
    
    //MARK: - Tableview Delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
   
    //MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textfield.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Add new category"
            textfield = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model manipulation methods
    func save(category: Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadCategories (){
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    func hexColor(){
        
        
    }
    
}


