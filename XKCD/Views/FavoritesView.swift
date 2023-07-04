//
//  FavoritesView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoriteComics: FavoriteComics
    
    var body: some View {
        Group {
            if !favoriteComics.isEmpty {
                ComicsGridView(comics: favoriteComics.comics, viewTitle: "Favorites")
            } else {
                NavigationStack {
                    Text("No favorties comics")
                        .navigationTitle("Favorites")
                }
            }
        }
    }
    
}
