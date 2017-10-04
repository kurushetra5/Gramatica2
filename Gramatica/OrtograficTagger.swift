//
//  OrtograficTagger.swift
//  Gramatica
//
//  Created by Kurushetra on 4/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation



class OrtograficTagger {
    
    
    var sentenceWords:[String] = ["Luis","es","el","mejor","de","todos"]
    var sentenceWords2:String = "Luis es el mejor de todos"
    var lookedTarget = "Verb"
    
    var targets:[String] = ["Verb","PersonalName","Adjective","Preposition","Determiner","com"]
    var sentenceTagged:[String:String] = [:]
    
    
    
    
    
    func checkMatch(word:String)  -> Bool {
        
        if word == sentenceTagged[lookedTarget] {
           return true
        }else {
           return false
        }
        
    }
    
    
    func newTarget() {
        lookedTarget = "Verb"
    }
    
    
    func newSentence() -> String {
        newTarget()
        tag(sentence:sentenceWords2)
        return sentenceWords2
    }
    
    
    func tag(sentence:String) {
        let range = NSRange(location:0, length:sentence.utf16.count)
        let tokenOptions = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.omitPunctuation.rawValue
        
        let tager:NSLinguisticTagger = NSLinguisticTagger(tagSchemes:NSLinguisticTagger.availableTagSchemes(forLanguage:"es"), options:Int(tokenOptions))
        
        tager.string = sentence
        
        tager.enumerateTags(in: range, scheme:.nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: tokenOptions),using: { tag, tokenRange,sentenceRange , stop in
            let world = (sentence as NSString).substring(with:tokenRange)
            let convertTag = tag!.rawValue
//            print("\(convertTag): \(world)")
            sentenceTagged[convertTag] = world
            
        })
//        print(sentenceTagged)
    }
    
    
}
