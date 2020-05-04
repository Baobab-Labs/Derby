//
//  Nutrition.swift
//  Derby
//
//  Created by Ben Hollar on 5/3/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation

public class Nutrition : ObservableObject {
    
    // MARK: - Properties
    
    /// The amount of calories (kCal)
    public var calories: Double
    
    /// The total fat (grams)
    public var totalFat: Double
    
    /// The saturated fat (grams)
    public var saturatedFat: Double
    
    /// The trans fat (grams)
    public var transFat: Double
    
    /// The cholesterol (milligrams)
    public var cholesterol: Double
    
    /// The sodium (milligrams)
    public var sodium: Double
    
    /// The carbohydrates (grams)
    public var carbohydrates: Double
    
    /// The amount of  fiber (grams)
    public var fiber: Double
    
    /// The amount of sugar  (grams)
    public var sugar: Double
    
    /// The protein content (grams)
    public var protein: Double
    
    // MARK: - Methods
    
    /// Create a new Nutrition object
    init(calories: Double = 0, totalFat: Double = 0, saturatedFat: Double = 0, transFat: Double = 0, cholesterol: Double = 0,
         sodium: Double = 0, carbohydrates: Double = 0, fiber: Double = 0, sugar: Double = 0, protein: Double = 0) {
        
        self.calories = calories
        self.totalFat = totalFat
        self.saturatedFat = saturatedFat
        self.transFat = transFat
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.carbohydrates = carbohydrates
        self.fiber = fiber
        self.sugar = sugar
        self.protein = protein
    }
    
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
        return Nutrition(calories: lhs.calories * rhs,
                         totalFat: lhs.totalFat * rhs,
                         saturatedFat: lhs.saturatedFat * rhs,
                         transFat: lhs.transFat * rhs,
                         cholesterol: lhs.cholesterol * rhs,
                         sodium: lhs.sodium * rhs,
                         carbohydrates: lhs.carbohydrates * rhs,
                         fiber: lhs.fiber * rhs,
                         sugar: lhs.sugar * rhs,
                         protein: lhs.protein * rhs)
    }
    
}

// MARK: - Extensions

extension Nutrition : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(calories)
        hasher.combine(totalFat)
        hasher.combine(saturatedFat)
        hasher.combine(transFat)
        hasher.combine(cholesterol)
        hasher.combine(sodium)
        hasher.combine(carbohydrates)
        hasher.combine(fiber)
        hasher.combine(sugar)
        hasher.combine(protein)
    }
    
}
