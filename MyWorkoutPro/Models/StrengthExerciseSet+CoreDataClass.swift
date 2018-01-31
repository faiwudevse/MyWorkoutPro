//
//  StrengthExerciseSet+CoreDataClass.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/19/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


public class StrengthExerciseSet: NSManagedObject {
    convenience init(weight: Float, resistance: Int16, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: "StrengthExerciseSet", in: context){
            self.init(entity: ent, insertInto: context)
            self.weight = weight
            self.resistance = resistance
        }
        else{
            fatalError("Unable to find Entity name!")
        }
    }
}
