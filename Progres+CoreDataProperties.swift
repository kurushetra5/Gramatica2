//
//  Progres+CoreDataProperties.swift
//  Gramatica
//
//  Created by Kurushetra on 11/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//
//

import Foundation
import CoreData


extension Progres {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progres> {
        return NSFetchRequest<Progres>(entityName: "Progres")
    }

    @NSManaged public var verbsWin: Int16
    @NSManaged public var verbsLose: Int16
    @NSManaged public var pronounWin: Int16
    @NSManaged public var pronounLose: Int16
    @NSManaged public var prepositionWin: Int16
    @NSManaged public var prepositionLose: Int16
    @NSManaged public var particleWin: Int16
    @NSManaged public var particleLose: Int16
    @NSManaged public var numberWin: Int16
    @NSManaged public var numberLose: Int16
    @NSManaged public var nounWin: Int16
    @NSManaged public var nounLose: Int16
    @NSManaged public var interjectionWin: Int16
    @NSManaged public var interjectionLose: Int16
    @NSManaged public var determinerWin: Int16
    @NSManaged public var determinerLose: Int16
    @NSManaged public var conjunctionWin: Int16
    @NSManaged public var conjunctionLose: Int16
    @NSManaged public var classifierWin: Int16
    @NSManaged public var classifierLose: Int16
    @NSManaged public var adverbWin: Int16
    @NSManaged public var adverbLose: Int16
    @NSManaged public var adjectiveWin: Int16
    @NSManaged public var adjectiveLose: Int16
    @NSManaged public var owner: Player?

}
