//
//  ContentView.swift
//  Derby
//
//  Created by Ben Hollar on 12/22/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import SwiftUI

struct RecipeCard: View {
    /// The recipe being illustrated on the card.
    @EnvironmentObject var recipe: Recipe
    
    var body: some View {
        VStack {
            if $recipe.imageName.wrappedValue != nil {
                Image($recipe.imageName.wrappedValue!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text($recipe.source.wrappedValue?.uppercased() ?? "")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text($recipe.name.wrappedValue)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text($recipe.summary.wrappedValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
            }
            .padding()
        }
        .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        .padding([.top, .horizontal])
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        RecipeCard().environmentObject(Recipe.DemoRecipe)
    }
}
