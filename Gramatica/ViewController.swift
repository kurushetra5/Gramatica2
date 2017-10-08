//
//  ViewController.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    
    @IBOutlet weak var tableViewStudents: UITableView!
    
    @IBAction func createStudent(_ sender: Any) {
        createNewStudent()
    }
    
    var students:[Student] = []
    
    var dictDefaults:[String : Any] {
        
           let defaults = UserDefaults.standard
        
        if let  keppedStudents:[String : Any] = defaults.dictionary(forKey:"Students") {
            
            let student:Student = Student(name:keppedStudents["Name"] as! String)
            student.level.actualLevel = keppedStudents["Level"] as! Int
            student.score = keppedStudents["Score"] as! Int
            students.append(student)
            return keppedStudents
        }else {
          
            let dict:[String : Any] = [:]
            defaults.set(dict, forKey: "Students")
            return dict
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        
         let defaults = UserDefaults.standard
        
        if let  keppedStudents:[String : Any] = defaults.dictionary(forKey:"Student") {
            
            let student:Student = Student(name:keppedStudents["Name"] as! String)
            student.level.actualLevel = keppedStudents["Level"] as! Int
            student.score = keppedStudents["Score"] as! Int
            students.append(student)
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func createNewStudent() {
        var userIdTextField: UITextField?
        let dialogMessage = UIAlertController(title: "NUEVO ESTUDIANTE", message: "Escribe tu nombre", preferredStyle: .alert)
        let ok = UIAlertAction(title: "CREAR", style: .default, handler: { (action) -> Void in
            
            if let userInput = userIdTextField!.text {
                let student:Student = Student(name:userInput)
                self.students.append(student)
                self.tableViewStudents.reloadData()
                
                
                let defaults = UserDefaults.standard
                let dict:[String : Any] = ["Name":student.name  , "Level":student.actualLevel,"Score":student.score]
                defaults.set(dict, forKey: "Student")
                
                
 
            }
        })
        
        let cancel = UIAlertAction(title: "CANCELAR", style: .cancel) { (action) -> Void in
            print("Cancelado crear estudiante")
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        dialogMessage.addTextField { (textField) -> Void in
            userIdTextField = textField
            userIdTextField?.placeholder = "Tu nombre"
        }
        self.present(dialogMessage, animated: true, completion: nil)
    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        cell.studentName.text = students[indexPath.row].name
        cell.studentScore.text = String(students[indexPath.row].score)
        cell.studentLevel.text = "Nivel \(students[indexPath.row].level.actualLevel)"
        cell.studentImage.image =  students[indexPath.row].studentImage
        return cell
    }
    
    
    
    

}

