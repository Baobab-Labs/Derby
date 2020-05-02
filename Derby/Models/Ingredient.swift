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
    
    public var name: String
    
    /// The amount of the ingredient to be used, stored in grams.
    public var quantity: Double
    
    // MARK: - Methods
    
    init(name: String, quantity: Double) {
        self.name = name
        self.quantity = quantity
    }
    
}

extension Ingredient : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(quantity)
    }
    
    public static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return (lhs.name == rhs.name) && (lhs.quantity == rhs.quantity)
    }
    
}
