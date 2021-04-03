//
//  Helper.swift
//  eisenhower_matrix
//
//  Created by Luda Parfenova on 03/04/2021.
//  Copyright © 2021 Luda Parfenova. All rights reserved.
//

import Foundation

class Helper {
    
    public static let sharedInstance = Helper()
    
    public func setToDoList() ->[String] {
        var todo = [String]()
        if UserDefaults.standard.object(forKey: "todoList") != nil {
           todo = UserDefaults.standard.object(forKey: "todoList") as! [String]
            return todo
        } else {
            return [""]
        }
    }
}
