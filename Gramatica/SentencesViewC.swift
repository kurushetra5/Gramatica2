//
//  SentencesViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class SentencesViewC: UIViewController,ExerciseDelegate {

    
    @IBOutlet weak var exerciseTaskLabel: UILabel!
    
    @IBOutlet weak var firtsButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirthButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var progresTime: KDCircularProgress!
    @IBOutlet weak var heartsGiftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
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
    var student:Student!
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        ortograficTagger.exerciseDelegate = self
        student = Student(name:"Luis")
        updateView()
        newExercise()
        progresTime.animate(toAngle:360, duration:10, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView() {
        scoreLabel.text = String(student.score)
        heartsGiftLabel.text = String(student.level.pointsForWiner())
    }
    
    func newExercise(sentence:String, target:String) {
        fill(target:target)
        fill(sentence:sentence)
        resetButtonColors()
        progresTime.animate(toAngle:360, duration:10, completion:nil)
    }
    
    
    func fill(target:String) {
        exerciseTaskLabel.text = target
    }
    func fill(sentence:String) {
        var sentence =  sentence.components(separatedBy:" ")
        firtsButton.setTitle(sentence[0], for:.normal)
        secondButton.setTitle(sentence[1], for:.normal)
        thirthButton.setTitle(sentence[2], for:.normal)
        fourthButton.setTitle(sentence[3], for:.normal)
        fifthButton.setTitle(sentence[4], for:.normal)
        sixthButton.setTitle(sentence[5], for:.normal)
    }
    
    
    func newExercise() {
        ortograficTagger.newExercise()
    }
    
    
    
    
    
    func  checkMatch(sender:UIButton) {
        
        if ortograficTagger.checkMatch(word:(sender.titleLabel?.text)!) {
            print("Acierto")
            sender.setTitleColor(.green, for:.normal)
            progresTime.stopAnimation()
            student.win()
            updateView()
            newExercise()
        }else {
            print("Error")
            sender.setTitleColor(.red, for:.normal)
        }
        
    }
    
    
    func resetButtonColors() {
        firtsButton.setTitleColor(.blue, for:.normal)
        secondButton.setTitleColor(.blue, for:.normal)
        thirthButton.setTitleColor(.blue, for:.normal)
        fourthButton.setTitleColor(.blue, for:.normal)
        fifthButton.setTitleColor(.blue, for:.normal)
        sixthButton.setTitleColor(.blue, for:.normal)
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
