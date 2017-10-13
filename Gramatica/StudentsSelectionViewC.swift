//
//  StudentsSelectionViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 13/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class StudentsSelectionViewC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    
    
    
    @IBOutlet weak var seltecStudentTittle: UILabel!
    
    @IBOutlet weak var studentsCollectionView: UICollectionView!
    
    @IBAction func newStudent(_ sender: Any) {
        createNewStudent()
    }
    
    
    
    var players:[Player] = []
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        fetchPlayers()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
         studentsCollectionView.reloadData()
    }
    
    
    
    func createNewStudent() {
        var userIdTextField: UITextField?
        let dialogMessage = UIAlertController(title: "NUEVO ESTUDIANTE", message: "Escribe tu nombre", preferredStyle: .alert)
        let ok = UIAlertAction(title: "CREAR", style: .default, handler: { (action) -> Void in
            
            if let userInput = userIdTextField!.text {
                self.newPlayer(name:userInput)
                self.fetchPlayers()
               self.studentsCollectionView.reloadData()
                
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

    
    
    
    
    
     //MARK: ------------------------------------------- COLLECTIO VIEW -------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studentChair",
                                                      for: indexPath) as! StudentSelectionCollectionViewCell
       
        cell.studentName.text = players[indexPath.row].name
        cell.studentImage.image = #imageLiteral(resourceName: "Silla")
        return cell
        
    }
    

    
    
    
  
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "studentMenu" {
             if let studentMenu = segue.destination as? StudentMenuViewC {
              
                studentMenu.player = players[studentsCollectionView.indexPathsForSelectedItems![0].row]
            
             }
         }
        
    }
   

}
