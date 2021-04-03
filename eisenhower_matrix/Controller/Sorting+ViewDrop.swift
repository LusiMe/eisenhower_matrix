//
//  Sorting+ViewDrop.swift
//  eisenhower_matrix
//
//  Created by Luda Parfenova on 28/03/2021.
//  Copyright © 2021 Luda Parfenova. All rights reserved.
//

import UIKit

extension SortingViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] { //questinable, it was an Image, could potentially broke
        guard let task = firstView.accessibilityLabel else { return [] }

        let provider = NSItemProvider(object: task as NSItemProviderWriting)
           let item = UIDragItem(itemProvider: provider)
           item.localObject = task
           
           /*
                Returning a non-empty array, as shown here, enables dragging. You
                can disable dragging by instead returning an empty array.
           */
           return [item]
    }
    
//    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
//        return // i don't need image - think about it
//            session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
//    }
    
    
}
