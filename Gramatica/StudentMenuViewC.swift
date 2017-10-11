//
//  StudentMenuViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 8/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class StudentMenuViewC: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var continueLevel: UIButton!
    
    @IBOutlet weak var rankTableView: UITableView!
    
    @IBOutlet weak var customPractice: UIButton!
    
     
    
    
    
    var rankTypes = [WordType.Verb.rawValue,WordType.Noun.rawValue,WordType.Adjective.rawValue,WordType.Determiner.rawValue,WordType.Adverb.rawValue,WordType.Pronoun.rawValue,  WordType.Preposition.rawValue,WordType.Conjunction.rawValue]
    
 
    
    var player:Player!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           rankTableView.reloadData()
            
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
NotificationCenter.default.addObserver(self, selector:#selector(targetOn), name:.onSelectedType, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(targetOff), name:.offSelectedType, object:nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func targetOff(notification: NSNotification) {
        print("Target OFF")
        print(notification.object!)
    }
    @objc func targetOn(notification: NSNotification) {
        print("Target ON")
        print(notification.object!)
    }
     
    func nameFor(type:WordType) -> String { //TODO: pasar clouser para no repetir cosas
        
        switch type {
        case  WordType.Verb:
            return  " Verbos"
        case  WordType.Adjective:
            return  " Adjetivos"
        case WordType.Noun:
            return  " Nombres"
        case  WordType.Pronoun:
            return " Pronombres"
        case WordType.Determiner:
            return  " Articulos"
        case  WordType.Particle:
            return " Particle"
        case  WordType.Preposition:
            return   " Preposiciones"
        case  WordType.Number:
            return  " Numeros"
        case  WordType.Conjunction:
            return " Conjunciones"
        case  WordType.Interjection:
            return  " Intersecciones"
        case  WordType.Classifier:
            return " Clasificadores"
        case  WordType.Adverb:
            return  " Adverbios"
        default:
            print("averageFor(type:WordType) -> Double ")
            return "No Set"
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankTypeCell", for: indexPath) as! RankTypeTableViewCell
        
//        cell.rankType.text = rankTypes[indexPath.row]
        
        cell.rankType.text = nameFor(type:WordType(rawValue: rankTypes[indexPath.row])!)
        
        cell.rankOwnerType = rankTypes[indexPath.row]
        let avg:Double = (player.progres?.averageFor(type:WordType(rawValue:rankTypes[indexPath.row])!))!
        
        let average:String = String(format: "%.0f", avg)
        cell.rankAverageLabel.text =  "\(average)%"
        cell.rankProgress(with:avg)
        
        cell.doneWinLoseLabel.text =  (player.progres?.categoryResults(type:WordType(rawValue:rankTypes[indexPath.row])!))
        return cell
    }
    
    
    
    
    
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sentencesGameView" {
            
            if let studentGameView = segue.destination as? SentencesViewC {
                 studentGameView.player = player
                
            }
        }
    }
  

}
