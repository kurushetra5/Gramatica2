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
            if to == "win" {
                adjectiveWin += 1
            }else if to == "lose" {
                adjectiveLose += 1
            }
            
        case WordType.Noun:
            if to == "win" {
                nounWin += 1
            }else if to == "lose" {
                nounLose += 1
            }

        case  WordType.Pronoun:
              if to == "win" {
            pronounWin += 1
           }else if to == "lose" {
            pronounLose += 1
           }
        
        case WordType.Determiner:
            if to == "win" {
                determinerWin += 1
            }else if to == "lose" {
                determinerLose += 1
            }

        case  WordType.Particle:
            if to == "win" {
                particleWin += 1
            }else if to == "lose" {
                particleLose += 1
            }

        case  WordType.Preposition:
            if to == "win" {
                prepositionWin += 1
            }else if to == "lose" {
                prepositionLose += 1
            }
        case  WordType.Number:
            if to == "win" {
                numberWin += 1
            }else if to == "lose" {
                numberLose += 1
            }
        case  WordType.Conjunction:
            if to == "win" {
                conjunctionWin += 1
            }else if to == "lose" {
                conjunctionLose += 1
            }
        case  WordType.Interjection:
            if to == "win" {
                interjectionWin += 1
            }else if to == "lose" {
                interjectionLose += 1
            }
        case  WordType.Classifier:
            if to == "win" {
                classifierWin += 1
            }else if to == "lose" {
                classifierLose += 1
            }
        default:
            print("Error:addRank(category:String, to:String) ")
        }
    }
    
    func averageFor(type:WordType) -> Double {
        
        switch type {
        case  WordType.Verb:
            return  makeAverage(win:Int(verbsWin), lose:Int(verbsLose))
        case  WordType.Adjective:
            return  makeAverage(win:Int(adjectiveWin), lose:Int(adjectiveLose))
        case WordType.Noun:
            return  makeAverage(win:Int(nounWin), lose:Int(nounLose))
        case  WordType.Pronoun:
            return makeAverage(win:Int(pronounWin), lose:Int(pronounLose))
        case WordType.Determiner:
            return  makeAverage(win:Int(determinerWin), lose:Int(determinerLose))
        case  WordType.Particle:
            return  makeAverage(win:Int(particleWin), lose:Int(particleLose))
        case  WordType.Preposition:
            return  makeAverage(win:Int(prepositionWin), lose:Int(prepositionLose))
        case  WordType.Number:
            return  makeAverage(win:Int(numberWin), lose:Int(numberLose))
        case  WordType.Conjunction:
            return  makeAverage(win:Int(conjunctionWin), lose:Int(conjunctionLose))
        case  WordType.Interjection:
            return  makeAverage(win:Int(interjectionWin), lose:Int(interjectionLose))
        case  WordType.Classifier:
            return  makeAverage(win:Int(classifierWin), lose:Int(classifierLose))
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
