//
//  AnimationsManager.swift
//  Gramatica
//
//  Created by Kurushetra on 18/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox



struct AnimationsManager {
    
 

//MARK: ----------------------------------- ANIMATIONS -----------------------------------

func sound(forAction:Int) { //        1006 1016
    let systemSoundId: SystemSoundID = SystemSoundID(forAction)
    AudioServicesPlaySystemSound(systemSoundId)
}


func textTransitionFade(text:String, label:UILabel!) {
    
    if label != nil {
        UIView.transition(with: label ,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak label] in
                            label?.text = text
            }, completion: nil)
    }
    
    
}


func stackViewOffAnimation(stackView:UIStackView) {
    
    let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
    animator.addAnimations {
        
        stackView.alpha = 0.0
    }
    
    
    animator.startAnimation()
}



func stackViewOnAnimation(stackView:UIStackView) {
    
    let animator = UIViewPropertyAnimator(duration: 1.8, curve:.easeInOut)
    animator.addAnimations {
        stackView.alpha = 1.0
        
    }
    
    
    animator.startAnimation()
}


func showFailAlerts(number:Int, alerts:[UIView]) {
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
    animator.addAnimations {
        
        if number == 1 {
            alerts[0].alpha = 1.0
        }
        if number == 2 {
            alerts[1].alpha = 1.0
        }
    }
    
    //        animator.addCompletion { (position) in
    //
    //        }
    animator.startAnimation()
}




func animationFail(playerCap:UIView, circularProgress:KDCircularProgress) {
    sound(forAction:1114)
    
    
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve:.easeInOut)
    animator.addAnimations {
        playerCap.layer.opacity = 0.0
        circularProgress.progressInsideFillColor = .red
    }
    
    animator.addCompletion { (position) in
        playerCap.layer.opacity = 1.0
        circularProgress.progressInsideFillColor = .gray
    }
    animator.startAnimation()
}





func animationMatch(playerCap:UIView, circularProgress:KDCircularProgress) {
    sound(forAction:1057)
    
    let animator = UIViewPropertyAnimator(duration:0.5, curve:.linear)
    animator.addAnimations {
        playerCap.layer.opacity = 0.0
        circularProgress.progressInsideFillColor = .green
    }
    
    animator.addCompletion { (position) in
        playerCap.layer.opacity = 1.0
        
        circularProgress.progressInsideFillColor = .gray
        
        
         //FIXME: esto se debe de poner en el Sintax
//        animationWinPoints()
//         newExercise()
        
    }
    animator.startAnimation()
}




func animationWinPoints(pointsView:UIView) {
    
    
    let animator = UIViewPropertyAnimator(duration:0.3, curve:.easeInOut)
    animator.addAnimations {
        pointsView.layer.opacity = 0.0
    }
    
    animator.addCompletion { (position) in
        pointsView.layer.opacity = 1.0
        
    }
    animator.startAnimation()
}


}
