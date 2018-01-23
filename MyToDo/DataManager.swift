//
//  DataManager.swift
//  MyToDo
//
//  Created by Angie Mugo on 23/01/2018.
//  Copyright © 2018 Angie Mugo. All rights reserved.
//

import Foundation

//get the data, serialise the json to data models and returns this to view model as a list of objects

class DataManager {
    
    let title: String
    let done: Bool
    
    init(item: ToDoItem) {
        self.title =  item.title
        self.done = item.done
    }
    
    public init? (_ pList: [String: Any]?) {
        guard let propertyList = pList, let title = propertyList["title"] as? String, let done = propertyList["done"] as? Bool
            else { return nil }
        self.title = title
        self.done = done
    }
    
    func toPropertyList() -> [String: Any]{
        
        return ["title": self.title as Any, "done": self.done as Any ]
    }
    
}
