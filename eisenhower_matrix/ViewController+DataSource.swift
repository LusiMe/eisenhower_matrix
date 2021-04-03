//
//  ViewController+DataSource.swift
//  eisenhower_matrix
//
//  Created by Mark Parfenov on 03/04/2021.
//  Copyright © 2021 Mark Parfenov. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! ToDoTableViewCell
        if todo.count > 0 {
            cell.taskName.text = todo[indexPath.row]
        }
        saveData(todo: todo)
        return cell
    }
}
