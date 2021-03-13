//
//  SortingViewController.swift
//  eisenhower_matrix
//
//  Created by Mark Parfenov on 16/01/2021.
//  Copyright © 2021 Mark Parfenov. All rights reserved.
//

import UIKit
import MobileCoreServices

class SortingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIDragInteractionDelegate, UITableViewDragDelegate, UIDropInteractionDelegate {
    
    var model = Model()
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = UserDefaults.standard.object(forKey: "todoList") as! [String]
        
        firstView.isUserInteractionEnabled = true
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
//        tableView.dropDelegate = self
        
        let dragInteraction = UIDragInteraction(delegate: self)
        tableView.addInteraction(dragInteraction)
        let dropInteraction = UIDropInteraction(delegate: self)
        firstView.addInteraction(dropInteraction)
        navigationItem.rightBarButtonItem = editButtonItem
        
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
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        return []
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
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
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return model.canHandle(session)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        // Accept only one drag item.
        guard session.items.count == 1 else { return dropProposal }
        
        // The .move drag operation is available only for dragging within this app and while in edit mode.
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            // Drag is coming from outside the app.
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }

        return dropProposal
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // Consume drag items.
            let stringItems = items as! [String]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.model.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
}
//extension SortingViewController: UICollectionViewDragDelegate {
//    func collectionView(_ collectionView: UICollectionView,
//                        itemsForBeginning session: UIDragSession,
//                        at indexPath: IndexPath) -> [UIDragItem] {
//        let dataSource = dataSourceForCollectionView(collectionView)
//        return dataSource.dragItems(for: indexPath)
//}
//}
