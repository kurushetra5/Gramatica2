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
    
    init(name:String) {
        self.name = name
    }
    
    var actualLevel:Int {
        return level.actualLevel
    }
    
    func win() {
        score += level.winerPoints
    }
     
    
    
}
