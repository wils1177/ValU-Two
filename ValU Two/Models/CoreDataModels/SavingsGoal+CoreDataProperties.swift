//
//  SavingsGoal+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/30/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension SavingsGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavingsGoal> {
        return NSFetchRequest<SavingsGoal>(entityName: "SavingsGoal")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var initialContribution: Double
    @NSManaged public var goalAmount: Double
    @NSManaged public var percentageOfSavings: Double
    @NSManaged public var currentBalance: Double
    @NSManaged public var autoContribute: Bool
    @NSManaged public var percentageOfAccount: Double

}

extension SavingsGoal : Identifiable {

}
