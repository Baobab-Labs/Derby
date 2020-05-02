//
//  SideMenu.swift
//  Derby
//
//  Created by Ben Hollar on 1/5/20.
//  Copyright © 2020 Ben Hollar. All rights reserved.
//

import SwiftUI

struct SideMenu: View {
    @Binding var collections: [RecipeCollection]
    
    @State var showingModal: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Collections")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .underline()
            VStack(alignment: .leading, spacing: 30) {
                ForEach($collections.wrappedValue, id: \.self) { collection in
                    Button(action: { self.showingModal.toggle() }) {
                        Text(collection.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }.sheet(isPresented: self.$showingModal) {
                        CollectionView().environmentObject(collection)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("DerbyPurpleDark")
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(collections: .constant([RecipeCollection(name: "All Recipes"),
                                         RecipeCollection(name: "Collection 1"),
                                         RecipeCollection(name: "Collection 2")])
        )
    }
}
