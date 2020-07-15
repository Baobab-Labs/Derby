//
//  Ingredient.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import Foundation
import CoreData

public class Ingredient : NSManagedObject, Nameable {
    
    // MARK: - Properties
    
    /// The name of the ingredient
    @NSManaged public var name: String
    
    /// The ingredient's nutritional information
    @NSManaged public var nutrition: Nutrition?
    
    /// The cost of the ingredient
    @NSManaged public var cost: Double
    
}

extension Ingredient {
    
    public static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return (lhs.name == rhs.name) && (lhs.nutrition == rhs.nutrition)
    }
    
}
