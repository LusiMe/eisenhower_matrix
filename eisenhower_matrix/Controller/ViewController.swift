//
//  ViewController.swift
//  eisenhower_matrix
//
//  Created by Luda Parfenova on 14/01/2021.
//  Copyright © 2021 Luda Parfenova. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate,  UITextFieldDelegate {
   
    var todo = [String]()
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var taskInput: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTask(_ sender: UIButton) {
        errorLabel.isHidden = true
        if taskInput.text != "" {
            todo.append(taskInput.text!)
            taskInput.text = ""
            self.tableView.reloadData()
        } else {
            errorLabel.text = "please, type the task name"
            errorLabel.isHidden = false
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskInput.delegate = self
        todo = Helper.sharedInstance.setToDoList()
       
        //hide keyboard on tap
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tapGesture)
        
    }
    //why not working
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.taskInput {
                errorLabel.isHidden = true
        }
        }
    
    public func saveData(todo: [String]) {
        UserDefaults.standard.set(todo, forKey: "todoList")
    }

    @IBAction func nextPage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "matrix")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

