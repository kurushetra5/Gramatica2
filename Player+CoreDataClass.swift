//
//  Player+CoreDataClass.swift
//  Gramatica
//
//  Created by Kurushetra on 11/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {

     
    
    func win(target:WordType, points:Int) {
        score +=  Int16(points)
        progres?.addRank(wordType:target, to:"win")
        
    }
    func lose(target:WordType) {
        progres?.addRank(wordType:target, to:"lose")
    }
    
    
    
}
