//
//  Workout+CoreDataClass.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/6/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


public class Workout: NSManagedObject {
    convenience init(name: String, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: "Workout", in: context){
            self.init(entity: ent, insertInto: context)
            self.name = name

        }else {
            fatalError("Unable to find Entity name!")
        }
    }
}
