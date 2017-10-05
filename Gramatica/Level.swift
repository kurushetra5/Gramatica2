//
//  Level.swift
//  Gramatica
//
//  Created by Kurushetra on 5/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation

class Level {
    
    var targetPoints:[Int:Int] = [1:5, 2:10]
    var actualLevel = 1
    var endLevel:Bool!
    var endGame:Bool!
    
    func increaseLevel() {
        actualLevel += 1
    }
    
    func pointsForWiner() -> Int {
        return targetPoints[actualLevel]!
    }
    
    
    
}
