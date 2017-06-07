//
//  StudentListTableViewController.swift
//  StudentPutApi
//
//  Created by Bradley GIlmore on 6/7/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var studentNameTextField: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func addStudentButtonTapped(_ sender: Any) {
        
        guard let studentName = studentNameTextField.text else { return }
        
        StudentController.putStudentWith(name: studentName) { (success) in
            if success {
                // Do Something
            } else {
                // Do something else
            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentController.students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        let student = StudentController.students[indexPath.row]
        
        cell.textLabel?.text = student.name
        
        return cell
    }
}
