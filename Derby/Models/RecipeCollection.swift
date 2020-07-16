//
//  RecipeCollection.swift
//  Derby
//
//  Created by Ben Hollar on 1/5/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation
import CoreData

public class RecipeCollection : NSManagedObject, Nameable {
    
    /// The name of the collection
    @NSManaged public var name: String
    
    /// The recipes of the collection
    @NSManaged public var recipes: Set<Recipe>
    
}

extension RecipeCollection {
    
    public static func == (lhs: RecipeCollection, rhs: RecipeCollection) -> Bool {
        return (lhs.name == rhs.name) && (lhs.recipes == rhs.recipes)
    }
    
}
