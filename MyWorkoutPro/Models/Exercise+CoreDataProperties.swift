//
//  Exercise+CoreDataProperties.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 1/6/18.
//  Copyright © 2018 Fai Wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var distance: Bool
    @NSManaged public var duration: Bool
    @NSManaged public var name: String?
    @NSManaged public var resistance: Bool
    @NSManaged public var type: Int16
    @NSManaged public var weight: Bool

}
