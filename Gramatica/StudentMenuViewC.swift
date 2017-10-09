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
    
    var student:Student!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankTypeCell", for: indexPath) as! RankTypeTableViewCell
        
        cell.rankType.text = rankTypes[indexPath.row]
        let average:String = String(student.rank.averageFor(type:WordType(rawValue:rankTypes[indexPath.row])!))
        cell.rankAverageLabel.text = average
        
        return cell
    }
    
    
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sentencesGameView" {
            
            if let studentGameView = segue.destination as? SentencesViewC {
                studentGameView.student = student
                
            }
        }
    }
  

}
