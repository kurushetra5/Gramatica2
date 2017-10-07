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


enum WordType:String {
    case Verb = "Verb",Noun = "Noun" , Adjective = "Adjective" ,Adverb = "Adverb", Pronoun = "Pronoun",Determiner = "Determiner", Particle = "Particle",Preposition = "Preposition", Number = "Number" ,Conjunction = "Conjunction",Interjection = "Interjection",Classifier = "Classifier", Idiom = "Idiom",OtherWord = "OtherWord",SentenceTerminator = "SentenceTerminator", OpenQuote = "OpenQuote",CloseQuote = "CloseQuote",OpenParenthesis = "OpenParenthesis",CloseParenthesis = "CloseParenthesis",WordJoiner = "WordJoiner",Dash = "Dash",OtherPunctuation = "OtherPunctuation",ParagraphBreak = "ParagraphBreak",OtherWhitespace = "OtherWhitespace"
}



class OrtograficTagger {
    
    var exerciseDelegate:ExerciseDelegate!
//    var sentenceWords:[String] = ["Paco","es","el","mejor","de","todos"]
    var sentenceWords2:[String] = ["No me mires con esa cara tan triste, Jorge","Ella y yo ya te dijimos que nadie debía salir de la clase","Sonrío pero desapareció sin decirnos nada"]
//   var sentenceWords2:[String] = ["David is running so far away from here","Paul is drinking a big bear in the bar","This is a very new app from luis sintes estevez"]
    var lookedTarget = "Verb"
    
     var targets:[String] = ["Verb","Noun" ,"Adjective","Adverb","Pronoun"]
//      var targets:[String] = ["Verb"]
    var sentenceTagged:[String:String] = [:]
     var sentenceTags:[Any] = []
    
    var selectedSentence:String!
    
    
    
    init() {
//       readFileText()
        
    }
    
    
    func readFileText() {
        
        let path = Bundle.main.path(forResource: "textos", ofType: "txt")
         var validSentences:[String] = []
        let url:URL = URL(fileURLWithPath:path!)
        
        do {
            let text = try String(contentsOf:url, encoding: .utf8)
            let sentences = tagText(text:text)
            
              print(validSentences.count)
            
            
            for sentence in sentences {
                
                let words = sentence.components(separatedBy:" ")
//                var niceSentence = sentence.replacingOccurrences(of:"", with:"")
                
                
                if words.count <= 7 && words.count >= 3 {
                    validSentences.append(sentence)
                }
                
                
//                for word in words.indices {
//                    if words[word] == "\n" ||  words[word].count == 0  {
//                        words.remove(at:words.indices.first!)
//                    }
//                }
            }
            
            
            sentenceWords2 = validSentences
            
            
            
        }
            
        catch {
            
        }
        
        
    }
    
    
    
    
  public  func newExercise() {
        lookedTarget =  newTarget()
       selectedSentence = newSentence()
    print(lookedTarget)
        if checkIfSentenceMatch() {
            let target = chooseType(forTag:lookedTarget)
            exerciseDelegate?.newExercise(sentence:selectedSentence, target:target)
        }else {
            newExercise()
        }
        
    }
    
    
  public  func checkMatch(word:String)  -> Bool {
    
    var match = false
    for tag  in sentenceTags {
        let aTag:[String:String] = tag as! [String : String]
        
        if aTag.keys.contains(lookedTarget) && aTag.values.contains(word) {
            match = true
        }
    }
    return match
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
        
        for tag  in sentenceTags {
            let aTag:[String:String] = tag as! [String : String]
            print(aTag)
            if aTag.keys.contains(lookedTarget) {
//                print(aTag.key)
                print(lookedTarget)
                isOk = true
            }
        }
        return isOk
    }
    
    
    
  private  func tag(sentence:String) {
    sentenceTagged  =  [:]
    sentenceTags = []
        let range = NSRange(location:0, length:sentence.utf16.count)
        let tokenOptions = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.omitPunctuation.rawValue
        
        let tager:NSLinguisticTagger = NSLinguisticTagger(tagSchemes:NSLinguisticTagger.availableTagSchemes(forLanguage:"es"), options:Int(tokenOptions))
        
        tager.string = sentence
        
        tager.enumerateTags(in: range, scheme:.nameTypeOrLexicalClass, options: NSLinguisticTagger.Options(rawValue: tokenOptions),using: { tag, tokenRange,sentenceRange , stop in
            let world = (sentence as NSString).substring(with:tokenRange)
            let convertTag = tag!.rawValue
            //FIXME: Aqui sobreescribe valores Cambiar
            sentenceTagged[convertTag] = world
            sentenceTags.append(sentenceTagged)
             sentenceTagged  =  [:]
        })
 print(sentenceTags)
    
    }
    
    
    func chooseType(forTag tag:String) -> String {
        print(tag)
        switch tag {
        case  WordType.Verb.rawValue:
           return "Verbo"
        case  WordType.Adjective.rawValue:
            return "Adjetivo"
        case  WordType.Adverb.rawValue:
            return "Adverbio"
        case  WordType.Classifier.rawValue:
            return "Clasificador"
        case  WordType.Determiner.rawValue:
            return "Adjetivo Det"
        case  WordType.Conjunction.rawValue:
            return "Conjuncion"
        case  WordType.Interjection.rawValue:
            return "Interseccion"
        case  WordType.Pronoun.rawValue:
            return "Pronombre"
        case  WordType.Noun.rawValue:
            return "Nombre sust o per"
        case  WordType.Preposition.rawValue:
            return "Preposicion"
        case  WordType.Particle.rawValue:
            return "Participio"
        case  WordType.Number.rawValue:
            return "Numero"
        case  WordType.OpenQuote.rawValue:
            return "Comillas"
        case  WordType.CloseQuote.rawValue:
            return "Comillas"
        case  WordType.OpenParenthesis.rawValue:
            return "Parentesis"
        case  WordType.CloseParenthesis.rawValue:
            return "Parentesis"
        case  WordType.Idiom.rawValue:
            return "Idioma"
        case  WordType.WordJoiner.rawValue:
            return "Guion"
        case  WordType.SentenceTerminator.rawValue:
            return "Fin Linea"
        case  WordType.Dash.rawValue:
            return "Barra"
        case  WordType.OtherWhitespace.rawValue:
            return "Espacio"
        case  WordType.OtherPunctuation.rawValue:
            return "Otra Puntuacion"
        case  WordType.OtherWord.rawValue:
            return "Otra Palabra"
        case  WordType.ParagraphBreak.rawValue:
            return "Paragrafo"
        
        default:
            return "Tag Type Not Found"
            
        }
    }
    
    
    
    
    private  func tagText(text:String) -> [String] {
 
        var sentences:[String] = []
        
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace ,.omitOther]
        tagger.enumerateTags(in: range, unit: .sentence, scheme: .tokenType, options: options) { _, tokenRange, _ in
            let word = (text as NSString).substring(with: tokenRange)
//            print("\(word)")
            sentences.append(word)
        }
        return sentences
    }
}
