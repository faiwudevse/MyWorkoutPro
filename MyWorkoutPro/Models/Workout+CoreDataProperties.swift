//
//  Workout+CoreDataProperties.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/6/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    @NSManaged public var workoutexercises: NSSet?

}

// MARK: Generated accessors for workoutexercises
extension Workout {

    @objc(addWorkoutexercisesObject:)
    @NSManaged public func addToWorkoutexercises(_ value: WorkoutExercise)

    @objc(removeWorkoutexercisesObject:)
    @NSManaged public func removeFromWorkoutexercises(_ value: WorkoutExercise)

    @objc(addWorkoutexercises:)
    @NSManaged public func addToWorkoutexercises(_ values: NSSet)

    @objc(removeWorkoutexercises:)
    @NSManaged public func removeFromWorkoutexercises(_ values: NSSet)

}
