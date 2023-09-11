//
//  FavoritesView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(filter: #Predicate<ComicModel> { $0.isFavorited }, animation: .easeIn)
    var comics: [ComicModel]
    
    var body: some View {
        Group {
            if !comics.isEmpty {
                ComicsGridView(comics: comics, viewTitle: "Favorites")
            } else {
                NavigationStack {
                    Text("No favorties comics")
                        .navigationTitle("Favorites")
                }
            }
        }
    }
    
}
