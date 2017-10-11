//
//  ViewController.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    
    @IBOutlet weak var tableViewStudents: UITableView!
    
    @IBAction func createStudent(_ sender: Any) {
        createNewStudent()
    }
    
 
    var players:[Player] = []
 
 
    
 
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
//            cleanDataBase()
          fetchPlayers()
        tableViewStudents.reloadData()
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //MARK: ------------------------------------------- CORE DATA -------------------------------------------
    func cleanDataBase() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try context.execute(request)
            
        } catch {
            // Error Handling
        }
    }
    
    
    func newPlayer(name:String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let player:Player = Player(context:context)
        let progres:Progres = Progres(context: context)
        progres.setValue(player, forKey: "owner")
        player.setValue(progres, forKey: "progres")
        player.setValue(name, forKey: "name")
        player.setValue(0, forKey: "score")
        player.setValue(1, forKey: "level")
//         player.setValue(#imageLiteral(resourceName: "noavatar"), forKey: "image")
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    
    func fetchPlayers() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         do {
            players = try context.fetch(Player.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        print(players)
    }
    
    func delete(player:Player) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(player)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        fetchPlayers()
        tableViewStudents.reloadData()
    }
    
    //MARK: -------------------------------------------Fin  CORE DATA -------------------------------------------
    
    
    func createNewStudent() {
        var userIdTextField: UITextField?
        let dialogMessage = UIAlertController(title: "NUEVO ESTUDIANTE", message: "Escribe tu nombre", preferredStyle: .alert)
        let ok = UIAlertAction(title: "CREAR", style: .default, handler: { (action) -> Void in
            
            if let userInput = userIdTextField!.text {
                self.newPlayer(name:userInput)
                self.fetchPlayers()
                self.tableViewStudents.reloadData()
                
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


//MARK: -------------------------- TABLE VIEW  --------------------------

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentsTableViewCell
        cell.studentName.text = players[indexPath.row].name
        cell.studentScore.text = String(players[indexPath.row].score)
        cell.studentLevel.text = "Nivel \(players[indexPath.row].level)"
        cell.studentImage.image =  #imageLiteral(resourceName: "noavatar")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let dialogMessage = UIAlertController(title: "QUITAR ESTUDIANTE", message: "¿Quitaras el estudiante para siempre?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "QUITAR", style: .default, handler: { (action) -> Void in
                self.delete(player:self.players[indexPath.row])
                
            })
            
            let cancel = UIAlertAction(title: "CANCELAR", style: .cancel) { (action) -> Void in
                print("Cancelado Borrar estudiante")
            }
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            self.present(dialogMessage, animated: true, completion: nil)
            }
    }
    
    
    
    //MARK: -------------------------- NAVIGATION  --------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "studentMenu" {
            
            if let studentMenu = segue.destination as? StudentMenuViewC {
                studentMenu.player = players[(tableViewStudents.indexPathForSelectedRow?.row)!]
                
            }
        }

    }
    

}

