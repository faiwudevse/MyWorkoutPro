//
//  WorkoutExercise+CoreDataClass.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/15/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


public class WorkoutExercise: NSManagedObject {
    convenience init(distance: Bool, duration: Bool, name: String, resistance: Bool, type: Int16, weight: Bool, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: "WorkoutExercise", in: context){
            self.init(entity: ent, insertInto: context)
            self.distance = distance
            self.duration = duration
            self.name = name
            self.resistance = resistance
            self.type = type
            self.weight = weight
        }else {
            fatalError("Unable to find Entity name!")
        }
    }}
