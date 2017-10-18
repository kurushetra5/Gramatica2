//
//  StringExtensions.swift
//  Gramatica
//
//  Created by Kurushetra on 15/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import Foundation


extension String {
    
    
    
    
    func isOnlyLetters() -> Bool {
        
        var result = true
        
        if self.containsOnlyLetters() {
            result =  true
        }else {
            let result2 = self.removeNonLetters()
            
            if result2.containsOnlyLetters() {
                result = true
                print("Removed non Letter OK")
            }else {
                result = false
//                fatalError("--OrtograficTagger--- Ha non letter is in the Word and is not removed/ --clean(word:String)")
                
            }
        }
        return result
    }
    
    
    
    func containsOnlyLetters() -> Bool {
        
        for chr in self.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) { //TODO: pensar lo de las majusculas
                return false
            }
        }
        return true
    }
    
    func removeNonLetters() -> String {
        
        let characterSet =  CharacterSet.init(charactersIn:"[,.?¿- \"")
        let finalString = (self.components(separatedBy: characterSet) as NSArray).componentsJoined(by: "")
        return finalString
    }
    
    
    
}
