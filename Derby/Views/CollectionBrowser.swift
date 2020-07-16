//
//  CollectionBrowser.swift
//  Derby
//
//  Created by Ben Hollar on 12/29/19.
//  Copyright © 2019 Ben Hollar. All rights reserved.
//

import SwiftUI
import CoreData

// MARK: - View
struct CollectionBrowser: View {
    
    /// The CoreData managed context for the application
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @FetchRequest(entity: RecipeCollection.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \RecipeCollection.name, ascending: true)]
    ) var collections: FetchedResults<RecipeCollection>
    
    var body: some View {
        NavigationView {
            List(collections, id: \.self) { collection in
                NavigationLink(
                    destination: CollectionView(collection: collection),
                    label: {
                        Text(collection.name)
                    })
            }
            .navigationBarTitle("Collections")
        }
    }
    
}

// MARK: - Helpers

struct CollectionList_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        CollectionBrowser().environment(\.managedObjectContext, context)
    }
}
