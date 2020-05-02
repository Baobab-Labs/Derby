//
//  CollectionView.swift
//  Derby
//
//  Created by Ben Hollar on 5/2/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var collection: RecipeCollection
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    Text($collection.name.wrappedValue)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    ForEach($collection.recipes.wrappedValue, id: \.self) { recipe in
                        RecipeCard().environmentObject(recipe)
                    }
                }
            }
            HStack(alignment: .center) {
                Button("ADD", action: self.addRecipe).buttonStyle(RoundedButonStyle())
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color("DerbyPurpleLight").edgesIgnoringSafeArea(.all))
        }
        .background(Color("DerbyPurple").edgesIgnoringSafeArea(.all))
    }
    
    private func addRecipe() {
        // TODO
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var DemoRecipe: Recipe = {
        let r = Recipe(name: "BA's Best Snickerdoodles")
        r.summary = "For the snickerdoodle purists."
        r.source = "Bon Appetit"
        r.imageName = "bon-appetit-snickerdoodle"
        return r
    }()
    
    static var previews: some View {
        CollectionView().environmentObject(RecipeCollection(name: "Collection 1",
                                                            recipes: [DemoRecipe,
                                                                      DemoRecipe,
                                                                      DemoRecipe]))
    }
}
