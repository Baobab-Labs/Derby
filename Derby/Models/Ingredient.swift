//
//  Ingredient.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import Foundation

public class Ingredient : Nameable, ObservableObject {
    
    // MARK: - Properties
    
    /// The name of the ingredient
    public var name: String
    
    /// The ingredient's nutritional information
    public var nutrition: Nutrition?
    
    /// The cost of the ingredient
    public var cost: Double?
    
    // MARK: - Methods
    
    /// Create a new ingredient
    init(name: String, nutrition: Nutrition? = nil) {
        self.name = name
        self.nutrition = nutrition
    }
    
}

extension Ingredient : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(nutrition)
        hasher.combine(cost)
    }
    
    public static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return (lhs.name == rhs.name) && (lhs.nutrition == rhs.nutrition)
    }
    
}
