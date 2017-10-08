//
//  Rank.swift
//  Gramatica
//
//  Created by Kurushetra on 8/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation



class Rank {
    
    struct Results {
        var win:Int = 0
        var lose:Int = 0
        
        mutating  func add(to:String) {
            switch to {
            case "win":
                 addWin()
            case "lose":
                 addLose()
            default:
                print("Error:addToResults ")
            }
        }
        mutating func addWin() {
            win += 1
        }
        mutating func addLose() {
            lose += 1
        }
    }
    
    
    struct Category {
        var results:Results = Results()
    }
    
    var verbs:Category = Category()
    var nouns:Category = Category()
    var adjective:Category = Category()
    var Pronoun:Category = Category()
    var Determiner:Category = Category()
    var Particle:Category = Category()
    
    
    func addRank(wordType:WordType, to:String) {
        
        switch wordType {
        case  WordType.Verb:
            verbs.results.add(to:to)
        case  WordType.Adjective:
            adjective.results.add(to:to)
            
        default:
            print("Error:addRank(category:String, to:String) ")
        }
    }
    
    
    
    
}
