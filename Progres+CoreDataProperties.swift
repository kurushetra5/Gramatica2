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
    @NSManaged public var owner: Player?

}
