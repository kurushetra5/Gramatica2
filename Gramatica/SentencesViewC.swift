//
//  SentencesViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class SentencesViewC: UIViewController {

    
    @IBOutlet weak var exerciseTaskLabel: UILabel!
    
    @IBOutlet weak var firtsButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirthButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    
    
    @IBAction func firtsWord(_ sender: UIButton) {
        checkMatch(sender:sender)
    }
    @IBAction func secondWord(_ sender: UIButton) {
        checkMatch(sender:sender)
    }
    @IBAction func thirthWord(_ sender: UIButton) {
        checkMatch(sender:sender)
    }
    @IBAction func fourthWord(_ sender: UIButton) {
        checkMatch(sender:sender)
    }
    @IBAction func fifthWord(_ sender: UIButton) {
       checkMatch(sender:sender)
    }
    @IBAction func sixthWord(_ sender: UIButton) {
        checkMatch(sender:sender)
    }
    
    
    
   var ortograficTagger = OrtograficTagger()
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        fillSentence()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fill(target:String) {
        exerciseTaskLabel.text = target
    }
    
    
    func fillSentence() {
       var sentence =  ortograficTagger.newSentence().components(separatedBy:" ")
        
       firtsButton.setTitle(sentence[0], for:.normal)
        
       secondButton.setTitle(sentence[1], for:.normal)
        thirthButton.setTitle(sentence[2], for:.normal)
        fourthButton.setTitle(sentence[3], for:.normal)
        fifthButton.setTitle(sentence[4], for:.normal)
        sixthButton.setTitle(sentence[5], for:.normal)
    }
    
    
    
    
    
    func  checkMatch(sender:UIButton) {
        
        if ortograficTagger.checkMatch(word:(sender.titleLabel?.text)!) {
            print("Acierto")
            sender.setTitleColor(.green, for:.normal)
            fill(target:ortograficTagger.newTarget())
        }else {
            print("Error")
            sender.setTitleColor(.red, for:.normal)
        }

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
