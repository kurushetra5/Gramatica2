//
//  TutorialViewC.swift
//  Gramatica
//
//  Created by Kurushetra on 14/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit



class TutorialViewC: SintaxTagger  {

    
    
    @IBOutlet weak var progresTimer: KDCircularProgress!
    
    @IBOutlet weak var studentCap: UIImageView!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var errorOneView: UIImageView!
    
    @IBOutlet weak var errorTwoView: UIImageView!
    
    @IBOutlet weak var scoreView: UILabel!
    
    @IBOutlet weak var CapPointsView: UIImageView!
    
    
    
    
    
    
    
    override func setIBOutlets() {

         circularProgres = self.progresTimer
         playerCap = self.studentCap
         targetTextLabel = self.targetLabel
         alertOne = self.errorOneView
         alertTwo = self.errorTwoView
         scoreLabel = self.scoreView
         heartPoints = self.CapPointsView
//        heartsGiftLabel //no lo pongo
        
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
