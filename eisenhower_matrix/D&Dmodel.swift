//
//  D&Dmodel.swift
//  eisenhower_matrix
//
//  Created by Luda Parfenova on 13/03/2021.
//  Copyright © 2021 Luda Parfenova. All rights reserved.
//
import UIKit
import MobileCoreServices

struct Model {
    private var tasks = UserDefaults.standard.object(forKey: "todoList") as! [String]
    
func canHandle(_ session: UIDropSession) -> Bool {
    return session.canLoadObjects(ofClass: NSString.self)
}
    /// The method for adding a new item to the table view's data model.
    mutating func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        
        let task = tasks[sourceIndex]
        tasks.remove(at: sourceIndex)
        tasks.insert(task, at: destinationIndex)
    }
    
    mutating func addItem(_ place: String, at index: Int) {
        tasks.insert(place, at: index)
    }
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let task = tasks[indexPath.row]

        let data = task.data(using: .utf8)
        let itemProvider = NSItemProvider()
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }

        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
    
}
