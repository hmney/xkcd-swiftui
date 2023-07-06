//
//  XKCDApp.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 29/5/2023.
//

import SwiftUI

@main
struct XKCDApp: App {
    
    @StateObject private var comicFetcher = ComicFetcher()
    @StateObject private var favoriteComics = FavoriteComics()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if comicFetcher.comics.isEmpty {
                    SplashView()
                } else {
                    HomeView()
                }
            }
            .task {
                try? await comicFetcher.fetchComics()
            }
            .environmentObject(comicFetcher)
            .environmentObject(favoriteComics)
            
        }
    }
}
