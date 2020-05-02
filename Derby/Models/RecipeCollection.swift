//
//  RecipeCollection.swift
//  Derby
//
//  Created by Ben Hollar on 1/5/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation

public class RecipeCollection : Nameable, ObservableObject {
    
    public var name: String
    
    public var recipes: [Recipe]
    
    convenience init() {
        self.init(name: "New Collection")
    }
    
    init(name: String, recipes: [Recipe] = []) {
        self.name = name
        self.recipes = recipes
    }
    
}

extension RecipeCollection : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(recipes)
    }
    
    public static func == (lhs: RecipeCollection, rhs: RecipeCollection) -> Bool {
        return (lhs.name == rhs.name) && (lhs.recipes == rhs.recipes)
    }
    
}
