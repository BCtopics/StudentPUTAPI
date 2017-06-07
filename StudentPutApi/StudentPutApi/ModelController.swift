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
    
    
    static func fetchAllStudents(completion: @escaping () -> Void) {
        
        
        guard let baseURL = baseURL?.appendingPathExtension("json") else { return }
        
        NetworkController.performRequest(for: baseURL, httpMethod: .get, urlParameters: nil, body: nil) { (data, error) in
            
            defer { completion() }
            
            if let error = error { NSLog("Error performing network request. \(error.localizedDescription)"); return }
            
            guard let data = data else { NSLog("Invalid Data"); return }
            guard let responseDataString = String(data: data, encoding: .utf8) else { return }
            
            guard let resultsDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: Any]] else { NSLog("Could not serialize data from JSON"); return }
            
            let students = resultsDictionary.flatMap { Student(dictionary: $0.value) }
        
            self.students = students
            
        }
        
    }
    
    
    
    
}










