//
//  ToDoItem.swift
//  MyToDo
//
//  Created by Angie Mugo on 17/01/2018.
//  Copyright © 2018 Angie Mugo. All rights reserved.
//

import Foundation

struct ToDoItem {
    
    var title: String
    var done: Bool
    
    public init(title: String) {
        self.title = title
        self.done = false
    }
    
    internal init(dataStore: DataManager) {
       self.title = dataStore.title
        self.done = dataStore.done
    }
    
    func toPlist() -> [String: Any]? {
        return ["title": self.title,
                "done": self.done]
    }
}
