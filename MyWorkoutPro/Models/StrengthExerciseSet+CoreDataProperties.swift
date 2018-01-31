//
//  StrengthExerciseSet+CoreDataProperties.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/19/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension StrengthExerciseSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StrengthExerciseSet> {
        return NSFetchRequest<StrengthExerciseSet>(entityName: "StrengthExerciseSet")
    }

    @NSManaged public var resistance: Int16
    @NSManaged public var weight: Float
    @NSManaged public var workoutexercise: WorkoutExercise?

}
