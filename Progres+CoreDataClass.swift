//
//  Progres+CoreDataClass.swift
//  Gramatica
//
//  Created by Kurushetra on 11/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Progres)
public class Progres: NSManagedObject {

    
    func addRank(wordType:WordType, to:String) {
        
        switch wordType {
            
        case  WordType.Verb:
            if to == "win" {
                 verbsWin += 1
            }else if to == "lose" {
                verbsLose += 1
            }
        case  WordType.Adjective:
//            adjective.results.add(to:to)
            print("no echo")
        case WordType.Noun:
//            nouns.results.add(to:to)
            print("no echo")
        case  WordType.Pronoun:
//            Pronoun.results.add(to:to)
            print("no echo")
        case WordType.Determiner:
//            Determiner.results.add(to:to)
            print("no echo")
        case  WordType.Particle:
//            Particle.results.add(to:to)
            print("no echo")
            
        default:
            print("Error:addRank(category:String, to:String) ")
        }
    }
    
    func averageFor(type:WordType) -> Double {
        
        switch type {
        case  WordType.Verb:
            return  makeAverage(win:Int(verbsWin), lose:Int(verbsLose))
        case  WordType.Adjective:
            return 0.0
        case WordType.Noun:
            return 0.0
        case  WordType.Pronoun:
            return 0.0
        case WordType.Determiner:
            return 0.0
        case  WordType.Particle:
            return 0.0
            
        default:
            print("averageFor(type:WordType) -> Double ")
            return 0.0
        }
        
    }
    
    func makeAverage(win:Int, lose:Int) -> Double {
        
        var result = 0.0
        if win == 0 && lose == 0 {
            return result
        }else {
            let sum =  win + lose
            let sum2:Float = Float(Double(win) / Double(sum))
            result = Double(sum2 * 100)
            
            return result
        }
        
    }
}
