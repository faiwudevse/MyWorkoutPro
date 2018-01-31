//
//  CardioExerciseSet+CoreDataProperties.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/18/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension CardioExerciseSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardioExerciseSet> {
        return NSFetchRequest<CardioExerciseSet>(entityName: "CardioExerciseSet")
    }

    @NSManaged public var distance: Float
    @NSManaged public var duration: String?
    @NSManaged public var workoutexercise: WorkoutExercise?

}
