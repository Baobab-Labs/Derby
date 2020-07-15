//
//  Nutrition.swift
//  Derby
//
//  Created by Ben Hollar on 5/3/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

public class Nutrition : NSManagedObject {
    
    // MARK: - Properties
    
    /// The amount of calories (kCal)
    @NSManaged public var calories: Double
    
    /// The total fat (grams)
    @NSManaged public var totalFat: Double
    
    /// The saturated fat (grams)
    @NSManaged public var saturatedFat: Double
    
    /// The trans fat (grams)
    @NSManaged public var transFat: Double
    
    /// The cholesterol (milligrams)
    @NSManaged public var cholesterol: Double
    
    /// The sodium (milligrams)
    @NSManaged public var sodium: Double
    
    /// The carbohydrates (grams)
    @NSManaged public var carbohydrates: Double
    
    /// The amount of  fiber (grams)
    @NSManaged public var fiber: Double
    
    /// The amount of sugar  (grams)
    @NSManaged public var sugar: Double
    
    /// The protein content (grams)
    @NSManaged public var protein: Double
    
}

// MARK: - Math Operators

extension Nutrition {
    
    public static func == (lhs: Nutrition, rhs: Nutrition) -> Bool {
        return (lhs.calories == rhs.calories) &&
               (lhs.totalFat == rhs.totalFat) &&
               (lhs.saturatedFat == rhs.saturatedFat) &&
               (lhs.transFat == rhs.transFat) &&
               (lhs.cholesterol == rhs.cholesterol) &&
               (lhs.sodium == rhs.sodium) &&
               (lhs.carbohydrates == rhs.carbohydrates) &&
               (lhs.fiber == rhs.fiber) &&
               (lhs.sugar == rhs.sugar) &&
               (lhs.protein == rhs.protein)
    }
    
    public static func * (lhs: Nutrition, rhs: Double) -> Nutrition {
        return {
            let nutrition = NSEntityDescription.insertNewObject(forEntityName: "Nutrition",
                                                                into: lhs.managedObjectContext!) as! Nutrition
            nutrition.calories = lhs.calories * rhs
            nutrition.totalFat = lhs.totalFat * rhs
            nutrition.saturatedFat = lhs.saturatedFat * rhs
            nutrition.transFat = lhs.transFat * rhs
            nutrition.cholesterol = lhs.cholesterol * rhs
            nutrition.sodium = lhs.sodium * rhs
            nutrition.carbohydrates = lhs.carbohydrates * rhs
            nutrition.fiber = lhs.fiber * rhs
            nutrition.sugar = lhs.sugar * rhs
            nutrition.protein = lhs.protein * rhs
            return nutrition
        }()
    }
    
}
