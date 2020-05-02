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
    
    /// Determines if the detailed card information should be displayed
    @State var showDetails: Bool = true
    
    var body: some View {
        ZStack {
            TitleSide().environmentObject(recipe)
                .rotation3DEffect(.degrees($showDetails.wrappedValue ? 180.0 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                .zIndex($showDetails.wrappedValue ? 0 : 1)
                .opacity($showDetails.wrappedValue ? 0 : 1)
            DetailSide().environmentObject(recipe)
                .rotation3DEffect(.degrees($showDetails.wrappedValue ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
                .zIndex($showDetails.wrappedValue ? 1 : 0)
                .opacity($showDetails.wrappedValue ? 1 : 0)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .rotation3DEffect(.degrees($showDetails.wrappedValue ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
        )
        .padding([.top, .horizontal])
        .onTapGesture {
            withAnimation(.easeOut(duration: 0.25)){
                self.showDetails.toggle()
            }
        }
    }
}

private struct TitleSide: View {
    @EnvironmentObject var recipe: Recipe
    
    var body: some View {
        VStack {
            Text($recipe.name.wrappedValue)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.white)
    }
}

private struct DetailSide: View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var DemoRecipe: Recipe = {
        let r = Recipe(name: "BA's Best Snickerdoodles")
        r.summary = "For the snickerdoodle purists."
        r.source = "Bon Appetit"
        r.imageName = "bon-appetit-snickerdoodle"
        return r
    }()
    
    static var previews: some View {
        RecipeCard().environmentObject(DemoRecipe)
    }
}
