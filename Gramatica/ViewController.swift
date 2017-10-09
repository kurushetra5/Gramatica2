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
    
    var dictDefaults:[String : Any] = [:]
 
    
    func checkDefaults() {
        
        let defaults = UserDefaults.standard
        
        if let  keppedStudents:[String : Any] = defaults.dictionary(forKey:"Students") {
           dictDefaults = keppedStudents
        }else {
            
            let dict:[String : Any] = [:]
            defaults.set(dict, forKey: "Students")
           dictDefaults = dict
    }
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        checkDefaults()
    for (key,value) in dictDefaults {
                
                let student:Student = Student(name:key)
                let dict:[String : Any] = value as! [String : Any]
                student.level.actualLevel = dict["Level"] as! Int
                student.score = dict["Score"] as! Int
        
        if let rankDict:[String : Int] = dict["Rank"] as? [String : Int] {
                   student.loadRank(withDict: rankDict)
                }
        
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
                self.dictDefaults[student.name] = dict
                defaults.set(self.dictDefaults, forKey:"Students")
                defaults.synchronize()
                
                
 
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "studentMenu" {
            
            if let studentMenu = segue.destination as? StudentMenuViewC {
                studentMenu.student = students[(tableViewStudents.indexPathForSelectedRow?.row)!]
                
            }
        }

    }
    

}

