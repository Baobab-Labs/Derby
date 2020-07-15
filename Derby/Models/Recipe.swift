//
//  Recipe.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import Foundation
import CoreData

public class Recipe : NSManagedObject, Nameable {
    
    // MARK: - Types
    
    public enum CookingDifficulty: Int16 {
        case beginner
        case basic
        case intermediate
        case advanced
        case expert
    }
    
    public enum RecipeQuality: Int16 {
        case disgusting
        case bad
        case average
        case good
        case delicious
    }
    
    // MARK: - Properties
    
    /// The name of the recipe
    @NSManaged public var name: String
    
    /// A concise description of the recipe.
    @NSManaged public var summary: String
    
    // The original source of the recipe.
    @NSManaged public var source: String?
    
    /// The ingredients of the recipe with associated quantities
    public var ingredients: [(ingredient: Ingredient, quantity: Double)] {
        get { return Array(zip(rawIngredientVals, rawIngredientQuantities)) }
        set { (self.rawIngredientVals, self.rawIngredientQuantities) = (newValue as [(Ingredient, Double)]).unzip() }
    }
    @NSManaged private var rawIngredientVals: [Ingredient]
    @NSManaged private var rawIngredientQuantities: [Double]
    
    /// The sequential instructions for making the recipe.
    @NSManaged public var instructions: [String]
    
    /// The name of the image associated with the recipe
    @NSManaged public var imageName: String?
    
    /// The number of minutes it takes to cook the recipe
    @NSManaged public var cookingTime: UInt
    
    /// The number of servings this recipe makes
    @NSManaged public var servings: UInt
    
    /// The complexity of the recipe
    public var cookingDifficulty: CookingDifficulty {
        get { return CookingDifficulty(rawValue: rawCookingDifficulty) ?? .beginner }
        set { self.rawCookingDifficulty = newValue.rawValue }
    }
    @NSManaged private var rawCookingDifficulty: Int16
    
    /// The user's rating of the recipe
    public var userRating: RecipeQuality {
        get { return RecipeQuality(rawValue: rawUserRating) ?? .average }
        set { self.rawUserRating = newValue.rawValue }
    }
    @NSManaged private var rawUserRating: Int16
    
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
        let nutrition = NSEntityDescription.insertNewObject(forEntityName: "Nutrition",
                                                            into: self.managedObjectContext!) as! Nutrition
        nutrition.calories = zip(nutritionObjs.compactMap({ $0.calories }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.totalFat = zip(nutritionObjs.compactMap({ $0.totalFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.saturatedFat = zip(nutritionObjs.compactMap({ $0.saturatedFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.transFat = zip(nutritionObjs.compactMap({ $0.transFat }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.cholesterol = zip(nutritionObjs.compactMap({ $0.cholesterol }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.sodium = zip(nutritionObjs.compactMap({ $0.sodium }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.carbohydrates = zip(nutritionObjs.compactMap({ $0.carbohydrates }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.fiber = zip(nutritionObjs.compactMap({ $0.fiber }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.sugar = zip(nutritionObjs.compactMap({ $0.sugar }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        nutrition.protein = zip(nutritionObjs.compactMap({ $0.protein }), ingredientQuantities).map({$0.0 * $0.1}).reduce(0, +)
        return nutrition
    }
    
    /// The cost per serving of the recipe
    public var costPerServing: Double? {
        if ingredients.isEmpty { return nil }
        
        let (ingredientObjs, ingredientQuantities) = splitIngredients()
        return zip(ingredientObjs.compactMap(({ $0.cost })), ingredientQuantities).map({ $0.0 * $0.1 }).reduce(0, +)
    }
    
    // MARK: - Methods
    
    public static func makeDemoRecipe(context: NSManagedObjectContext) -> Recipe {
        let r = Recipe(context: context)
        r.name = "Snickerdoodles"
        r.summary = "For the snickerdoodle purists."
        r.source = "Bon Appetit"
        r.imageName = "bon-appetit-snickerdoodle"
        return r
    }
    
    private func splitIngredients() -> ([Ingredient], [Double]) {
        return (ingredients.compactMap { $0.ingredient },
                ingredients.compactMap { $0.quantity })
    }
    
}

extension Recipe {
    
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
