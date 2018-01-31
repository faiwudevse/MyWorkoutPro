//
//  CardioExerciseSet+CoreDataClass.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/18/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


public class CardioExerciseSet: NSManagedObject {
    convenience init(distance: Float, duration: String, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: "CardioExerciseSet", in: context){
            self.init(entity: ent, insertInto: context)
            self.distance = distance
            self.duration = duration
        }else {
            fatalError("Unable to find Entity name!")
        }
    }
}
