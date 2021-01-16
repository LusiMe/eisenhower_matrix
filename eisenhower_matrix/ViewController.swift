//
//  ViewController.swift
//  eisenhower_matrix
//
//  Created by Mark Parfenov on 14/01/2021.
//  Copyright © 2021 Mark Parfenov. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var todo = [String]()
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTask(_ sender: UIButton) {
        errorLabel.isHidden = true
        if textField.text != "" {
            todo.append(textField.text!)
            textField.text = ""
            self.tableView.reloadData()
        } else {
            errorLabel.text = "please, type the task name"
            errorLabel.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        todo = UserDefaults.standard.object(forKey: "todoList") as! [String]
        
        if self.textField.isEditing { //not working
            errorLabel.isHidden = true
        }
        //TODO: find the way to hide errorLable if textField is editing
    }
    
    private func saveData(todo: [String]) {
        UserDefaults.standard.set(todo, forKey: "todoList")
    }
    
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
    
    
    @IBAction func nextPage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "matrix")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

