//
//  Player+CoreDataProperties.swift
//  Gramatica
//
//  Created by Kurushetra on 11/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var level: Int16
    @NSManaged public var name: String?
    @NSManaged public var score: Int16
    @NSManaged public var progres: Progres?

}
