//
//  Recipe.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import Foundation

public class Recipe : Nameable, ObservableObject {
    
    // MARK: - Types
    
    public enum CookingDifficulty {
        case beginner
        case basic
        case intermediate
        case advanced
        case expert
    }
    
    public enum RecipeQuality {
        case disgusting
        case bad
        case average
        case good
        case delicious
    }
    
    // MARK: - Properties
    
    /// The name of the recipe
    public var name: String
    
    /// A concise description of the recipe.
    public var summary: String = ""
    
    // The original source of the recipe.
    public var source: String?
    
    /// The ingredients of the recipe with associated quantities
    public var ingredients: [(ingredient: Ingredient, quantity: Double)] = []
    
    /// The sequential instructions for making the recipe.
    public var instructions: [String] = []
    
    /// The name of the image associated with the recipe
    public var imageName: String?
    
    /// The number of minutes it takes to cook the recipe
    public var cookingTime: UInt?
    
    /// The number of servings this recipe makes
    public var servings: UInt?
    
    /// The complexity of the recipe
    public var cookingDifficulty: CookingDifficulty?
    
    /// The user's rating of the recipe
    public var userRating: RecipeQuality?
    
    // MARK: - Computed Properties
    
    /// The total nutrition information of the recipe, derived from its ingredients
    public var nutriton: Nutrition? {
        if ingredients.isEmpty { return nil }
        
        // I apologize for doing this on a series of one-liners instead of in a loop. Simply put, we:
        //      1. Get each Nutrition for each ingredient
        //      2. Get each element of each Nutrition
        //      3. Multiply each element by the quantity of each ingredient
        //      4. Sum each element
        //      5. Make a new Nutrition using those values
        // nil-valued nutrition on any ingredient is ignored, per `compactMap`
        let (ingredientObjs, ingredientQuantities) = splitIngredients()
        let nutritionObjs = ingredientObjs.compactMap { $0.nutrition }
        return Nutrition(calories: zip(nutritionObjs.compactMap({ $0.calories }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         totalFat: zip(nutritionObjs.compactMap({ $0.totalFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         saturatedFat: zip(nutritionObjs.compactMap({ $0.saturatedFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         transFat: zip(nutritionObjs.compactMap({ $0.transFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         cholesterol: zip(nutritionObjs.compactMap({ $0.cholesterol }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         sodium: zip(nutritionObjs.compactMap({ $0.sodium }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         carbohydrates: zip(nutritionObjs.compactMap({ $0.carbohydrates }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         fiber: zip(nutritionObjs.compactMap({ $0.fiber }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         sugar: zip(nutritionObjs.compactMap({ $0.sugar }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +),
                         protein: zip(nutritionObjs.compactMap({ $0.protein }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +))
    }
    
    /// The cost per serving of the recipe
    public var costPerServing: Double? {
        if ingredients.isEmpty { return nil }
        
        let (ingredientObjs, ingredientQuantities) = splitIngredients()
        return zip(ingredientObjs.compactMap(({ $0.cost })), ingredientQuantities).map({ $0.0 * $0.1 }).reduce(0, +)
    }
    
    // MARK: - Methods
    
    /// Create a new Recipe named "New Recipe"
    convenience init() {
        self.init(name: "New Recipe")
    }
    
    /// Create a new Recipe
    /// - Parameter name: The name of the recipe
    init(name: String) {
        self.name = name
    }
    
    static var DemoRecipe: Recipe = {
        let r = Recipe(name: "BA's Best Snickerdoodles")
        r.summary = "For the snickerdoodle purists."
        r.source = "Bon Appetit"
        r.imageName = "bon-appetit-snickerdoodle"
        return r
    }()
    
    private func splitIngredients() -> ([Ingredient], [Double]) {
        return (ingredients.compactMap { $0.ingredient },
                ingredients.compactMap { $0.quantity })
    }
    
}

extension Recipe : Hashable {
    
    public func hash(into hasher: inout Hasher) {
        let (ingredientObjs, ingredientQuantities) = splitIngredients()
        hasher.combine(name)
        hasher.combine(ingredientObjs)
        hasher.combine(ingredientQuantities)
    }
    
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        let (ingredientObjsL, ingredientQuantitiesL) = lhs.splitIngredients()
        let (ingredientObjsR, ingredientQuantitiesR) = rhs.splitIngredients()
        return (lhs.name == rhs.name) &&
               (lhs.summary == rhs.summary) &&
               (lhs.source == rhs.source) &&
               (ingredientObjsL == ingredientObjsR) &&
               (ingredientQuantitiesL == ingredientQuantitiesR) &&
               (lhs.instructions == rhs.instructions) &&
               (lhs.imageName == rhs.imageName) &&
               (lhs.cookingTime == rhs.cookingTime) &&
               (lhs.servings == rhs.servings) &&
               (lhs.cookingDifficulty == rhs.cookingDifficulty) &&
               (lhs.userRating == rhs.userRating)
    }
    
}
