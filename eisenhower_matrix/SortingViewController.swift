//
//  SortingViewController.swift
//  eisenhower_matrix
//
//  Created by Mark Parfenov on 16/01/2021.
//  Copyright © 2021 Mark Parfenov. All rights reserved.
//

import UIKit

class SortingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = UserDefaults.standard.object(forKey: "todoList") as! [String]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksToSort", for: indexPath) as! SortingTableViewCell
        if tasks.count > 0 {
            cell.tasksName.text = tasks[indexPath.row]
        }
        return cell
    }
    
    

}
