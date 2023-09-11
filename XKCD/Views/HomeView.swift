//
//  HomeView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("BookmarkedComicNumber") private var bookmarkedComicNumber: Int?

    var body: some View {
        TabView {
            AllComicsView()
                .tabItem {
                    Label {
                        Text("Comics")
                            .font(.xkdcFont(size: 20))
                    } icon: {
                        Image("comic_list")
                    }
                    .font(.xkdcFont(size: 20))


                }
            
            BookmarkedView(bookmarkedComicNumber: bookmarkedComicNumber)
                .tabItem {
                    Label("Bookmark", systemImage: "bookmark.fill")
                    
                }
            
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
