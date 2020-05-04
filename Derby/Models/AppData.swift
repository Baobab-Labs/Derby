//
//  AppData.swift
//  Derby
//
//  Created by Ben Hollar on 1/5/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation

public class AppData: ObservableObject {
    /// The user's RecipeCollections
    @Published var collections: [RecipeCollection]
    
    /// Create a new AppData with a default RecipeCollection
    convenience init() {
        self.init(collections: [RecipeCollection(name: "All Recipes",
                                                 recipes: [Recipe(name: "Test")])])
    }
    
    /// Create a new AppData
    /// - Parameter collections: the user's RecipeCollections
    init(collections: [RecipeCollection]) {
        self.collections = collections
    }
}
