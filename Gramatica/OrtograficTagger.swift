//
//  OrtograficTagger.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation

protocol ExerciseDelegate {
    func newExercise(sentence:String, target:String)
}


class OrtograficTagger {
    
    var exerciseDelegate:ExerciseDelegate!
//    var sentenceWords:[String] = ["Paco","es","el","mejor","de","todos"]
//    var sentenceWords2:[String] = ["Paco es el mejor de todos","Paco era mas guapo que tu","Paco no come mucho por ahora"]
     var sentenceWords2:[String] = ["David is running so far away","Paul is drinking a big bear","This is a very new app"]
    var lookedTarget = "Verb"
    
    var targets:[String] = ["Verb","PersonalName","Adjective","Preposition","Determiner"]
    var sentenceTagged:[String:String] = [:]
    var selectedSentence:String!
    
    
    
    
    
  public  func newExercise() {
        lookedTarget =  newTarget()
       selectedSentence = newSentence()
        if checkIfSentenceMatch() {
            exerciseDelegate?.newExercise(sentence:selectedSentence, target:lookedTarget)
        }else {
            newExercise()
        }
        
    }
    
    
  public  func checkMatch(word:String)  -> Bool {
        
        if word == sentenceTagged[lookedTarget] {
           return true
        }else {
           return false
        }
        
    }
    
    
  private  func newTarget() -> String {
        let randomNumber = Int(arc4random_uniform(UInt32(targets.count)))
        return targets[randomNumber]
    }
    
  private  func newSentence() -> String {
        let randomNumber = Int(arc4random_uniform(UInt32(sentenceWords2.count)))
        print(randomNumber)
        return sentenceWords2[randomNumber]
    }
    
    
    
    
  private  func checkIfSentenceMatch() -> Bool {
        
        var isOk:Bool = false
        tag(sentence:selectedSentence)
        
        for tag  in sentenceTagged {
            if tag.key == lookedTarget {
                print(tag.key)
                print(lookedTarget)
                isOk = true
            }
        }
        return isOk
    }
    
    
    
  private  func tag(sentence:String) {
    sentenceTagged  =  [:]
        let range = NSRange(location:0, length:sentence.utf16.count)
        let tokenOptions = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.omitPunctuation.rawValue
        
        let tager:NSLinguisticTagger = NSLinguisticTagger(tagSchemes:NSLinguisticTagger.availableTagSchemes(forLanguage:"es"), options:Int(tokenOptions))
        
        tager.string = sentence
        
        tager.enumerateTags(in: range, scheme:.nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: tokenOptions),using: { tag, tokenRange,sentenceRange , stop in
            let world = (sentence as NSString).substring(with:tokenRange)
            let convertTag = tag!.rawValue
            sentenceTagged[convertTag] = world
            
        })
 
    }
    
    
}
