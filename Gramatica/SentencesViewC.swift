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
    
 
     var stackSentences: UIStackView!
    
    @IBOutlet weak var progresTime: KDCircularProgress!
    @IBOutlet weak var heartsGiftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
 
    var sentenceWith:Double = 0.0
    var ortograficTagger = OrtograficTagger()
    var student:Student!
    var timer:Timer!
    var timerCounter:Int = 0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ortograficTagger.exerciseDelegate = self
        student = Student(name:"Luis")
        updateView()
        newExercise()
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func startTimerEvery(seconds:Double) {
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector:#selector(timerFire), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFire() {  //FIXME: cambiar ha swift  @objc
        
        timerCounter += 1
        if timerCounter == 10 {
 
            updateView()
            stopTimer()
            progresTime.stopAnimation()
            newExercise()
        }else if timerCounter == 5 || timerCounter == 8 {
            student.level.tildForTime()
            heartsGiftLabel.text = String(student.level.winerPoints)
            
        }
        
    }
    
    func stopTimer() {
        timerCounter = 0
        if (timer != nil) {
            timer.invalidate()
        }
    }
    
    
    
    
    
    
    func updateView() {
        student.level.resetTild()
        scoreLabel.text = String(student.score)
        heartsGiftLabel.text = String(student.level.winerPoints)
        
    }
    
    
    func newExercise(sentence:String, target:String) {
        
        fill(target:target)
        fill(sentence:sentence)
        resetButtonColors()
        startTimerEvery(seconds:1.0)
        progresTime.animate(toAngle:360, duration:10) { (finish) in
            if finish == true {
  
            }
            
        }
    }
    
    
    func fill(target:String) {
        exerciseTaskLabel.text = target
    }
    
    
    func addStackView(views:[UILabel],  letfConstrain:Double, rightConstrain:Double) {
        
        if stackSentences != nil {
        stackSentences.removeFromSuperview()
        }
 
        stackSentences = UIStackView(arrangedSubviews:views)
        stackSentences.axis = .horizontal
        stackSentences.distribution = .fillProportionally
        stackSentences.spacing = 3
        stackSentences.alignment = .center
        stackSentences.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackSentences)
        stackSentences.leftAnchor.constraint(equalTo:view.leftAnchor, constant:CGFloat(letfConstrain)).isActive = true
        stackSentences.rightAnchor.constraint(equalTo:view.rightAnchor, constant:CGFloat(rightConstrain)).isActive = true
        stackSentences.topAnchor.constraint(equalTo:view.bottomAnchor, constant:-60).isActive = true
        stackSentences.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:CGFloat(0.0)).isActive = true
    }
    
    
    func fill(sentence:String) {
        
        sentenceWith = 0.0
        var labels:[UILabel] = []
        let sentence =  sentence.components(separatedBy:" ")
        
        for word in sentence {
            labels.append(addLabel(withText:word))
        }
        
        for label in labels {
            sentenceWith += Double(label.frame.width)
            print(label.frame.width)
        }


        let currentViewWith:Double = Double(view.frame.width)
        let emptySpace:Double = currentViewWith - sentenceWith
        let stackConstrain:Double = emptySpace / 2
        print(stackConstrain)
        
        addStackView(views:labels ,  letfConstrain:stackConstrain/1.4 , rightConstrain:-stackConstrain/1.4)
    }
    
    
    
    
    func addLabel(withText:String) -> UILabel {
        let label:UILabel = UILabel()
        label.text = withText
        label.font = UIFont(name: "HelveticaNeue", size:30)
        label.tintColor = .white
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        
        return label
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let label:UILabel = sender.view as! UILabel
        checkMatch(sender:label)
    }
    
    
    func newExercise() {
        ortograficTagger.newExercise()
    }
    
    
    
    
    
    func  checkMatch(sender:UILabel) {
        
        if ortograficTagger.checkMatch(word:(sender.text)!) {
            print("Acierto")
//            sender.setTitleColor(.green, for:.normal)
            stopTimer()
            progresTime.stopAnimation()
            student.win()
            student.level.resetTild()
            updateView()
            newExercise()
        }else {
            print("Error")
//            sender.setTitleColor(.red, for:.normal)
             stopTimer()
             progresTime.stopAnimation()
                         sleep(UInt32(2.0))
            updateView()
             newExercise()
        }
        
    }
    
    
    func resetButtonColors() {
 
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
