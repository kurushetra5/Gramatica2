//
//  SentencesViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit
import AudioToolbox
import SpriteKit

class SentencesViewC: UIViewController,ExerciseDelegate {
    
    
    @IBOutlet weak var exerciseTaskLabel: UILabel!
    
 
     var stackSentences: UIStackView!
    
    @IBOutlet weak var progresTime: KDCircularProgress!
    @IBOutlet weak var heartsGiftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var heartTimer: UIImageView!
    @IBOutlet weak var heartPoints: UIImageView!
    @IBOutlet weak var alertOne: UIImageView!
    @IBOutlet weak var alertTwo: UIImageView!
    
    @IBAction func pauseOrPlayButton(_ sender: UIButton ) {
                    stopTimer()
                    progresTime.stopAnimation()
                    invalidateLabels()
        
//        if sender.title == "PAUSE" {
//            stopTimer()
//            progresTime.stopAnimation()
//            invalidateLabels()
//            sender.title = "PLAY"
//        }else if sender.title == "PLAY" {
//            sender.title = "PAUSE"
//            validateLabels()
//            newExercise()
//        }
    }
    
    @IBAction func stopPlaying(_ sender: UIButton) {
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        stopTimer()
        progresTime.stopAnimation()
        dismiss(animated: true, completion:nil)
    }
    
    
    var sentenceWith:Double = 0.0
    var ortograficTagger:OrtograficTagger!
 
    var player:Player!
    var timer:Timer!
    var timerCounter:Int = 0
    var failedTimes:Int = 0
    var labels:[UILabel] = []
    var tilds:Int = 0
    var winerPoints:Int = 0
    var typesOn:[String] = []
    var typesOff:[String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideFailedAlerts()
        ortograficTagger = OrtograficTagger(withTargets:typesOn)
        ortograficTagger.exerciseDelegate = self
 
        updateView()
        newExercise()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        stopTimer()
        progresTime.stopAnimation()
        
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func hideFailedAlerts() {
        alertOne.alpha = 0.0
        alertTwo.alpha = 0.0
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
            failedTimes = 0
            hideFailedAlerts()
            
        }else if timerCounter == 5 || timerCounter == 8 {
            tildForTime()
            heartsGiftLabel.text = String(winerPoints)
            animationTild()
            
        }
        
    }
    
    func stopTimer() {
        timerCounter = 0
        if (timer != nil) {
            timer.invalidate()
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
    
    
    func invalidateLabels() {
        for label in labels {
            label.isUserInteractionEnabled = false
        }
    }
    
    func  validateLabels() {
        for label in labels {
            label.isUserInteractionEnabled = true
        }
    }
    
    
    func updateView() {
        tilds = 0
        winerPoints = 5
        failedTimes = 0
        scoreLabel.text = String(player.score)
        heartsGiftLabel.text = String(winerPoints)
        
    }
    
    //MARK: ----------------------------------- TAGGER DELEGATES -----------------------------------
    func newExercise(sentence:String, target:String) {
        
        fill(target:target)
        fill(sentence:sentence)
        resetButtonColors()
         stopTimer()
        startTimerEvery(seconds:1.0)
        progresTime.animate(toAngle:360, duration:10) { (finish) in
            if finish == true {
  
            }
            
        }
    }
    
    
    func fill(target:String) {
        textTransitionFade(text:target)
        
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
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let label:UILabel = sender.view as! UILabel
        label.isUserInteractionEnabled = false
        checkMatch(sender:label)
        
//        if let particles = SKEmitterNode(fileNamed: "MyParticle.sks") {
//            particles.position = label.layer.position
//
//        }
    }
    
    
    func newExercise() {
        ortograficTagger.newExercise()
        sound(forAction:1016)
    }
    
  
    
    
    
    func  checkMatch(sender:UILabel) {
        
        if ortograficTagger.checkMatch(word:(sender.text)!) {
            print("Acierto")
             sender.textColor = .green
             hideFailedAlerts()
            stopTimer()
             progresTime.stopAnimation()
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
              progresTime.stopAnimation()
//                 student.lose(target:ortograficTagger.target)
                player.lose(target:ortograficTagger.target)
                
                updateView()
                newExercise()
                
            }
            
        }
        
    }
    
    
    
    func textTransitionFade(text:String) {
        
        UIView.transition(with: exerciseTaskLabel,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.exerciseTaskLabel.text = text
            }, completion: nil)
    }
    
    
    func showFailAlerts(number:Int) {
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
        animator.addAnimations {
            
            if number == 1 {
            self.alertOne.alpha = 1.0
            }
            if number == 2 {
                self.alertTwo.alpha = 1.0
            }
        }
        
//        animator.addCompletion { (position) in
//
//        }
        animator.startAnimation()
    }
    
    func stackViewOnAnimation() {
        
        let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
        animator.addAnimations {
            self.stackSentences.alpha = 1.0
            
        }
        
        
        animator.startAnimation()
    }
    
    
    func stackViewOffAnimation() {
        
        let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
        animator.addAnimations {
            
            self.stackSentences.alpha = 0.0
        }
        
        
        animator.startAnimation()
    }
    
    
    
    func resetButtonColors() {
 
    }
    
    
    func sound(forAction:Int) { //        1006 1016
        let systemSoundId: SystemSoundID = SystemSoundID(forAction)
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    
    func animationTild() {
        animationHeartBeat()
//        let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
//        animator.addAnimations {
//            self.heartTimer.layer.opacity = 0.0
//
//        }
//
//        animator.addCompletion { (position) in
//            self.heartTimer.layer.opacity = 1.0
//
//        }
//        animator.startAnimation()
     }
    
    func animationFail() {
        sound(forAction:1114)
 
        
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
        animator.addAnimations {
          self.heartTimer.layer.opacity = 0.0
          self.progresTime.progressInsideFillColor = .red
        }
        
        animator.addCompletion { (position) in
            self.heartTimer.layer.opacity = 1.0
            self.progresTime.progressInsideFillColor = .gray
        }
        animator.startAnimation()
    }
    
    
     func animationHeartBeat() {
        sound(forAction:1306)
    
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options:
            UIViewAnimationOptions(rawValue: UIViewAnimationOptions.autoreverse.rawValue)  , animations: {
                
                self.heartTimer.transform = CGAffineTransform(scaleX: 1.2, y: 1.1)
        }, completion: { finished in
            self.heartTimer.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        
    }
    
    
    func animationMatch() {
         sound(forAction:1057)
        
        let animator = UIViewPropertyAnimator(duration:0.5, curve:.linear)
        animator.addAnimations {
              self.heartTimer.layer.opacity = 0.0
            self.progresTime.progressInsideFillColor = .green
        }
    
        animator.addCompletion { (position) in
              self.heartTimer.layer.opacity = 1.0
            
            self.progresTime.progressInsideFillColor = .gray
//            self.stopTimer()
//            self.progresTime.stopAnimation()
//            self.student.win()
//            self.student.level.resetTild()
//            self.updateView()
            self.animationWinPoints()
            self.newExercise()
            
        }
        animator.startAnimation()
    }
    
    func animationWinPoints() {
        
        
        let animator = UIViewPropertyAnimator(duration:0.3, curve:.easeInOut)
        animator.addAnimations {
            self.heartPoints.layer.opacity = 0.0
        }
        
        animator.addCompletion { (position) in
             self.heartPoints.layer.opacity = 1.0
            
        }
        animator.startAnimation()
    }
    
    
    
    
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//     }
    
    
}
