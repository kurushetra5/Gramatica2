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
    
     
    
    
    
    var rankTypes = [WordType.Verb.rawValue,WordType.Noun.rawValue,WordType.Adjective.rawValue,WordType.Adverb.rawValue,WordType.Pronoun.rawValue,WordType.Determiner.rawValue,WordType.Particle.rawValue,WordType.Preposition.rawValue,WordType.Conjunction.rawValue,WordType.Interjection.rawValue,WordType.Classifier.rawValue]
    
 
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
     
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankTypeCell", for: indexPath) as! RankTypeTableViewCell
        
        cell.rankType.text = rankTypes[indexPath.row]
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
