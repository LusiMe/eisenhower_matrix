//
//  D&Dmodel.swift
//  eisenhower_matrix
//
//  Created by Mark Parfenov on 13/03/2021.
//  Copyright © 2021 Mark Parfenov. All rights reserved.
//
import UIKit
import MobileCoreServices

struct Model {
    private var tasks = UserDefaults.standard.object(forKey: "todoList") as! [String]
    
func canHandle(_ session: UIDropSession) -> Bool {
    return session.canLoadObjects(ofClass: NSString.self)
}
    /// The method for adding a new item to the table view's data model.
    mutating func addItem(_ place: String, at index: Int) {
        tasks.insert(place, at: index)
    }
    
}
