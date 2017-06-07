//
//  Student.swift
//  StudentPutApi
//
//  Created by Bradley GIlmore on 6/7/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class Student {
    
    //MARK: - Keys
    
    private let nameKey = "name"
    
    //MARK: - Internal Properties
    
    let name: String
    
    //MARK: - Initializers
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: Any]) {
        
        guard let name = dictionary[nameKey] as? String else { return nil }
        
        self.name = name
    }
    
    var dictionaryReperesentation: [String: Any] {
        return [nameKey: name]
    }
    
}
