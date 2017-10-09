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
    
    var verbsAverage:Double {
        return makeAverage(win:verbs.results.win, lose:verbs.results.lose)
    }
    
    
    var nounsAverage:Double {
        return makeAverage(win:nouns.results.win, lose:nouns.results.lose)
    }
    
    var adjectiveAverage:Double{
        return makeAverage(win:adjective.results.win, lose:adjective.results.lose)
    }
    var PronounAverage:Double{
        return makeAverage(win:Pronoun.results.win, lose:Pronoun.results.lose)
    }
    var DeterminerAverage:Double{
        return makeAverage(win:Determiner.results.win, lose:Determiner.results.lose)
    }
    var ParticleAverage:Double{
        return makeAverage(win:Particle.results.win, lose:Particle.results.lose)
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
    
    func averageFor(type:WordType) -> Double {
        
        switch type {
        case  WordType.Verb:
           return verbsAverage
        case  WordType.Adjective:
            return adjectiveAverage
        case WordType.Noun:
            return nounsAverage
        case  WordType.Pronoun:
           return PronounAverage
        case WordType.Determiner:
            return DeterminerAverage
        case  WordType.Particle:
            return ParticleAverage
            
        default:
            print("averageFor(type:WordType) -> Double ")
            return 0.0
         }
        
    }
    
    func addRank(wordType:WordType, to:String) {
        
        switch wordType {
        case  WordType.Verb:
            verbs.results.add(to:to)
        case  WordType.Adjective:
            adjective.results.add(to:to)
        case WordType.Noun:
            nouns.results.add(to:to)
        case  WordType.Pronoun:
            Pronoun.results.add(to:to)
        case WordType.Determiner:
            Determiner.results.add(to:to)
        case  WordType.Particle:
            Particle.results.add(to:to)
            
        default:
            print("Error:addRank(category:String, to:String) ")
        }
    }
    
    
    func rankFrom(dict:[String : Int]) -> Rank {
        let rank:Rank = Rank()
        rank.verbs.results.win = dict["verbsWin"]!
        rank.verbs.results.lose = dict["verbsLose"]!
        rank.nouns.results.win =   dict["nounsWin"]!
        rank.nouns.results.lose =   dict["nounsLose"]!
        rank.adjective.results.win =   dict["adjectiveWin"]!
        rank.adjective.results.lose =   dict["adjectiveLose"]!
        rank.Pronoun.results.win =   dict["PronounWin"]!
        rank.Pronoun.results.lose =   dict["PronounLose"]!
        rank.Determiner.results.win =   dict["DeterminerWin"]!
        rank.Determiner.results.lose =   dict["DeterminerLose"]!
        rank.Particle.results.win =   dict["ParticleWin"]!
        rank.Particle.results.lose =   dict["ParticleLose"]!
        return rank
    }
    
    
    func dictFromRank() -> [String : Int] {
        
        let dict:[String : Int] = ["verbsWin":verbs.results.win, "verbsLose":verbs.results.lose ,
                                   "nounsWin": nouns.results.win, "nounsLose":nouns.results.lose,
                                   "adjectiveWin": adjective.results.win, "adjectiveLose":adjective.results.lose,
                                   "PronounWin": Pronoun.results.win, "PronounLose":Pronoun.results.lose,
                                   "DeterminerWin": Determiner.results.win, "DeterminerLose":Determiner.results.lose,
                                   "ParticleWin": Particle.results.win, "ParticleLose":Particle.results.lose]
        return dict
    }
    
    
}













