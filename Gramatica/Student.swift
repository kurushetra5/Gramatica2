//
//  Student.swift
//  Gramatica
//
//  Created by Kurushetra on 5/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation


class Student {
    
    var name:String!
    var score:Int = 0
    var level:Level = Level()
    var rank:Rank = Rank()
    
    
    init(name:String) {
        self.name = name
        }
    
    var actualLevel:Int {
        return level.actualLevel
    }
    
    func win(target:WordType) {
        score += level.winerPoints
        rank.addRank(wordType:target, to:"win")
//        rank.verbs.results.addWin()
//       print(rank.verbs.results.win)
    }
    
    func lose(target:WordType) {
         rank.addRank(wordType:target, to:"lose")
    }
        
    
    
}
