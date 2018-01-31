//
//  WorkoutExercise+CoreDataProperties.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/15/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutExercise> {
        return NSFetchRequest<WorkoutExercise>(entityName: "WorkoutExercise")
    }

    @NSManaged public var distance: Bool
    @NSManaged public var duration: Bool
    @NSManaged public var name: String?
    @NSManaged public var resistance: Bool
    @NSManaged public var type: Int16
    @NSManaged public var weight: Bool
    @NSManaged public var cardioexercise: CardioExerciseSet?
    @NSManaged public var strengthexercises: NSSet?
    @NSManaged public var workout: Workout?

}

// MARK: Generated accessors for strengthexercises
extension WorkoutExercise {

    @objc(addStrengthexercisesObject:)
    @NSManaged public func addToStrengthexercises(_ value: StrengthExerciseSet)

    @objc(removeStrengthexercisesObject:)
    @NSManaged public func removeFromStrengthexercises(_ value: StrengthExerciseSet)

    @objc(addStrengthexercises:)
    @NSManaged public func addToStrengthexercises(_ values: NSSet)

    @objc(removeStrengthexercises:)
    @NSManaged public func removeFromStrengthexercises(_ values: NSSet)

}
