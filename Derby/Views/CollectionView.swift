//
//  CollectionView.swift
//  Derby
//
//  Created by Ben Hollar on 7/15/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import SwiftUI
import CoreData

// MARK: - View
struct CollectionView: View {
    
    @ObservedObject var collection: RecipeCollection
    
    var body: some View {
        List(Array(collection.recipes), id: \.self) { recipe in
            RecipeCard(recipe: recipe)
        }
    }
    
}

// MARK: - Helpers

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let collection = RecipeCollection(context: context)
        collection.name = "All Recipes"
        collection.recipes = [Recipe.makeDemoRecipe(context: context)]
        return CollectionView(collection: collection)
    }
}
