//
//  StudentsSelectionViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 13/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class StudentsSelectionViewC: UIViewController {

    
    @IBOutlet weak var seltecStudentTittle: UILabel!
    
    
    @IBAction func newStudent(_ sender: Any) {
        
    }
    
    
    
    var players:[Player] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 //MARK: ------------------------------------------- CORE DATA -------------------------------------------
    func fetchPlayers() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            players = try context.fetch(Player.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        print(players)
    }
    
    
    
    
  
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "studentMenu" {
//            if let studentMenu = segue.destination as? StudentMenuViewC {
//             studentMenu.player = players[(tableViewStudents.indexPathForSelectedRow?.row)!]
            
//            }
         }
        
    }
   

}
