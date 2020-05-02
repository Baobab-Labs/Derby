//
//  AppData.swift
//  Derby
//
//  Created by Ben Hollar on 1/5/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import Foundation

public class AppData: ObservableObject {
    @Published var collections: [RecipeCollection]
    
    convenience init() {
        self.init(collections: [RecipeCollection(name: "All Recipes",
                                                 recipes: [Recipe(name: "Test")])])
    }
    
    init(collections: [RecipeCollection]) {
        self.collections = collections
    }
}
