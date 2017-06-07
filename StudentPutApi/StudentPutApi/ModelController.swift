//
//  ModelController.swift
//  StudentPutApi
//
//  Created by Bradley GIlmore on 6/7/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class StudentController {
    
    static let baseURL = URL(string: "https://studentputapi-3a581.firebaseio.com/students")
    
    static var students: [Student] = []
    
    static func putStudentWith(name: String, completion: @escaping (_ success: Bool) -> Void) {
        
        var success = false
        defer { completion(success) }
        
        let student = Student(name: name)
        
        guard let baseURL = baseURL else { return }
        let newEndPoint = baseURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("json")
        
        NetworkController.performRequest(for: newEndPoint, httpMethod: .put, urlParameters: nil, body: student.jsonData) { (data, error) in
            
            if let error = error {
                NSLog("Error \(error)")
            }

            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { return }
            
            if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            } else {
                print("Successfully put student \(student.name) at endpoint. \n\(responseDataString))")
            }
            
            success = true
            
            self.students.append(student)
            
        }
    }
}
