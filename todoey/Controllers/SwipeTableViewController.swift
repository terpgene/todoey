//
//  SwipeTableViewController.swift
//  todoey
//
//  Created by Gene Essel on 4/19/18.
//  Copyright © 2018 Gene Essel. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
    }
    
    //TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil}
        
        print ("delet cell")
        let deletAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

            self.updateModel(at: indexPath)
 
       }
        
        //customize the action appearance
       deletAction.image = UIImage(named: "delete")
        
       return [deletAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
        
    }
    
    func updateModel(at indexPath: IndexPath){
       // Update data model
    }

  }
    

