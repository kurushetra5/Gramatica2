//
//  Student.swift
//  Gramatica
//
//  Created by Kurushetra on 5/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation
import UIKit


class Student {
    
    var name:String!
    var image:UIImage!
    var score:Int = 0
    var level:Level = Level()
    var rank:Rank = Rank()
    
    var studentImage:UIImage {
        if image == nil {
           return #imageLiteral(resourceName: "noavatar")
        }else {
            return image
        }
    }
    
    init(name:String) {
        self.name = name
        }
    
    var actualLevel:Int {
        return level.actualLevel
    }
    
    
    func win(target:WordType) {
        score += level.winerPoints
        rank.addRank(wordType:target, to:"win")
        
    }
    
    
    func lose(target:WordType) {
         rank.addRank(wordType:target, to:"lose")
    }
        
    
    
}
