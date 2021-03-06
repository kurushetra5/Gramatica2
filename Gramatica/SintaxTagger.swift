//
//  SintaxTagger.swift
//  Gramatica
//
//  Created by Kurushetra on 14/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox




class SintaxTagger:UIViewController ,ExerciseDelegate {
    
    
    
    
    //MARK: ----------------------------------- VARS -----------------------------------
    //-Objects
    var circularProgres: KDCircularProgress!
    var ortograficTagger:OrtograficTagger!
    var player:Player!
    var animationsManager:AnimationsManager = AnimationsManager() //TODO: falta probar lo
    
    
    //-StackView
    var stackSentences: UIStackView!
    var sentenceWith:Double = 0.0
    var labels:[UILabel] = []
    
    //-Timer
    var timer:Timer!
    var timerCounter:Int = 0
    
    
    //-Outlets Images
    var playerCap: UIImageView!
    var heartPoints: UIImageView!
    var alertOne: UIImageView!
    var alertTwo: UIImageView!
    
     //-Outlets Labels
    var targetTextLabel:UILabel!
    var heartsGiftLabel: UILabel!
    var scoreLabel: UILabel!
    
    //-Game State
    var failedTimes:Int = 0
    var tilds:Int = 0
    var winerPoints:Int = 0
    var typesOn:[String] = []
    var typesOff:[String] = []
    
    
    
    
    
    //MARK: ----------------------------------- LIFE CIRCLE -----------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setIBOutlets()
        setPlayer()
        ortograficTagger = OrtograficTagger(withTargets:typesOn)
        ortograficTagger.exerciseDelegate = self
        newExercise()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        stopTimer()
        circularProgres?.stopAnimation()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK: ----------------------------------- ABSTRACT -----------------------------------
    func setIBOutlets() {
        // To implement in Subclas
        print("setIBOutlets() To implement in Subclas")
    }
    
    func setPlayer() {
        // To implement in Subclas
        print("setPlayer()  To implement in Subclas")
        newPlayer(name:"Tutorial")
    }
    
    
    
    
    //MARK: ----------------------------------- PLAYER -----------------------------------
    
    func newPlayer(name:String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        player  = Player(context:context)
        let progres:Progres = Progres(context: context)
        progres.setValue(player, forKey: "owner")
        player.setValue(progres, forKey: "progres")
        player.setValue(name, forKey: "name")
        player.setValue(0, forKey: "score")
        player.setValue(1, forKey: "level")
        //         player.setValue(#imageLiteral(resourceName: "noavatar"), forKey: "image")
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    
    //MARK: ----------------------------------- VIEW SETUPS -----------------------------------
    
    
    func updateView() {
        tilds = 0
        winerPoints = 5
        failedTimes = 0
        scoreLabel?.text = String(player.score)
        heartsGiftLabel?.text = String(winerPoints)
        
    }
    
    func hideFailedAlerts() {
        alertOne?.alpha = 0.0
        alertTwo?.alpha = 0.0
    }
    
    
    func fill(target:String) {
        textTransitionFade(text:target)
        
    }
    
    
    func fill(sentence:String) {
        
        labels = []
        
        sentenceWith = 0.0
        
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
        label.font = UIFont(name: "HelveticaNeue", size:35)
        label.tintColor = .white
        label.textColor = .white
        label.textAlignment = .center
        //        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        
        return label
    }
    
    
    
    
    func addStackView(views:[UILabel],  letfConstrain:Double, rightConstrain:Double) {
        
        if stackSentences != nil {
            //        stackSentences.removeFromSuperview()
            stackViewOffAnimation()
            self.stackSentences.removeFromSuperview()
        }
        
        stackSentences = UIStackView(arrangedSubviews:views)
        stackSentences.alpha = 0.0
        stackSentences.axis = .horizontal
        stackSentences.distribution = .fillProportionally
        stackSentences.spacing = 4
        stackSentences.alignment = .center
        stackSentences.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackSentences)
        stackSentences.leftAnchor.constraint(equalTo:view.leftAnchor, constant:CGFloat(0)).isActive = true
        stackSentences.rightAnchor.constraint(equalTo:view.rightAnchor, constant:CGFloat(0)).isActive = true
        stackSentences.topAnchor.constraint(equalTo:view.bottomAnchor, constant:-70).isActive = true
        stackSentences.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:CGFloat(0.0)).isActive = true
        stackViewOnAnimation()
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let label:UILabel = sender.view as! UILabel
        label.isUserInteractionEnabled = false
        checkMatch(sender:label)
        
        
    }
    
    
    func  checkMatch(sender:UILabel) {
        
        if ortograficTagger.checkMatch(word:(sender.text)!) {
            print("Acierto")
            sender.textColor = .green
            hideFailedAlerts()
            stopTimer()
            circularProgres?.stopAnimation()
            player.win(target:ortograficTagger.target, points:winerPoints)
            updateView()
            //             animationWinPoints()
            animationMatch()
            
            
        }else {
            print("Error")
            sender.textColor = .red
            
            animationFail()
            failedTimes += 1
            //             updateView()
            //              newExercise()
            //            sleep(UInt32(2.0))
            if self.failedTimes == 1 {
                showFailAlerts(number:1)
            }else if self.failedTimes == 2 {
                showFailAlerts(number:2)
            }else if self.failedTimes == 3 {
                sound(forAction:1024)
                sleep(UInt32(1.0))
                self.failedTimes = 0
                hideFailedAlerts()
                stopTimer()
                circularProgres?.stopAnimation()
                //                 student.lose(target:ortograficTagger.target)
                player.lose(target:ortograficTagger.target)
                
                updateView()
                newExercise()
                
            }
            
        }
        
    }
    
    
    
    
    
    //MARK: ----------------------------------- TIMER -----------------------------------
    func startTimerEvery(seconds:Double) {
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector:#selector(timerFire), userInfo: nil, repeats: true)
        
    }
    
    func stopTimer() {
        timerCounter = 0
        if (timer != nil) {
            timer.invalidate()
        }
    }
    
    @objc func timerFire() {
        
        timerCounter += 1
        if timerCounter == 10 {
            updateView()
            stopTimer()
            circularProgres?.stopAnimation()
            failedTimes = 0
            hideFailedAlerts()
            newExercise()
            
        }else if timerCounter == 5 || timerCounter == 8 {
            tildForTime()
            
            heartsGiftLabel?.text = String(winerPoints)
            //            animationTild()
            
        }
        
    }
    
    func tildForTime() {
        tilds += 1
        if tilds == 1 {
            winerPoints = 4
        }
        if tilds == 2 {
            winerPoints = 3
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: ----------------------------------- TAGGER -----------------------------------
    
    func newExercise() {
        ortograficTagger.newExercise()
        sound(forAction:1016)
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: ----------------------------------- TAGGER DELEGATES -----------------------------------
    func newExercise(sentence:String, target:String) {
        
        fill(target:target)
        fill(sentence:sentence)
        //        resetButtonColors()
        stopTimer()
        startTimerEvery(seconds:1.0)
        circularProgres?.animate(toAngle:360, duration:10) { (finish) in
            if finish == true {
                
            }
            
        }
    }
    
    
    
    
    
    //MARK: ----------------------------------- ANIMATIONS -----------------------------------
    
    func sound(forAction:Int) { //        1006 1016
        let systemSoundId: SystemSoundID = SystemSoundID(forAction)
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    
    func textTransitionFade(text:String) {
        
        if targetTextLabel != nil {
            UIView.transition(with: targetTextLabel ,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self?.targetTextLabel.text = text
                }, completion: nil)
        }
        
        
    }
    
    
    func stackViewOffAnimation() {
        
        let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
        animator.addAnimations {
            
            self.stackSentences.alpha = 0.0
        }
        
        
        animator.startAnimation()
    }
    
    
    func stackViewOnAnimation() {
        
        let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
        animator.addAnimations {
            self.stackSentences.alpha = 1.0
            
        }
        
        
        animator.startAnimation()
    }
    
    
    func showFailAlerts(number:Int) {
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
        animator.addAnimations {
            
            if number == 1 {
                self.alertOne?.alpha = 1.0
            }
            if number == 2 {
                self.alertTwo?.alpha = 1.0
            }
        }
        
        //        animator.addCompletion { (position) in
        //
        //        }
        animator.startAnimation()
    }
    
    
    
    
    func animationFail() {
        sound(forAction:1114)
        
        
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
        animator.addAnimations {
            self.playerCap?.layer.opacity = 0.0
            self.circularProgres?.progressInsideFillColor = .red
        }
        
        animator.addCompletion { (position) in
            self.playerCap?.layer.opacity = 1.0
            self.circularProgres?.progressInsideFillColor = .gray
        }
        animator.startAnimation()
    }
    
    
    
    
    
    func animationMatch() {
        sound(forAction:1057)
        
        let animator = UIViewPropertyAnimator(duration:0.5, curve:.linear)
        animator.addAnimations {
            self.playerCap?.layer.opacity = 0.0
            self.circularProgres?.progressInsideFillColor = .green
        }
        
        animator.addCompletion { (position) in
            self.playerCap?.layer.opacity = 1.0
            
            self.circularProgres?.progressInsideFillColor = .gray
            self.animationWinPoints()
            self.newExercise()
            
        }
        animator.startAnimation()
    }
    
    
    
    
    func animationWinPoints() {
        
        
        let animator = UIViewPropertyAnimator(duration:0.3, curve:.easeInOut)
        animator.addAnimations {
            self.heartPoints?.layer.opacity = 0.0
        }
        
        animator.addCompletion { (position) in
            self.heartPoints?.layer.opacity = 1.0
            
        }
        animator.startAnimation()
    }
    
    
}
