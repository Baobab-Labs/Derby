//
//  Recipe.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import Foundation

public class Recipe : Nameable, ObservableObject {
    
    // MARK: - Properties
    
    public var name: String
    
    /// A concise description of the recipe.
    public var summary: String = ""
    
    // If availble, the original source of the recipe.
    public var source: String? = nil
    
    /// The ingredients of the recipe.
    public var ingredients: [Ingredient] = []
    
    /// The sequential instructions for making the recipe.
    public var instructions: [String] = []
    
    public var imageName: String?
    
    // MARK: - Methods
    
    convenience init() {
        self.init(name: "New Recipe")
    }
    
    init(name: String) {
        self.name = name
    }
    
}

extension Recipe : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(summary)
        hasher.combine(source)
        hasher.combine(ingredients)
        hasher.combine(instructions)
        hasher.combine(instructions)
        hasher.combine(imageName)
    }
    
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return (lhs.name == rhs.name) &&
               (lhs.summary == rhs.summary) &&
               (lhs.source == rhs.source) &&
               (lhs.ingredients == rhs.ingredients) &&
               (lhs.instructions == rhs.instructions) &&
               (lhs.imageName == rhs.imageName)
    }
    
}
