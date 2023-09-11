//
//  ContentView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 10/9/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var comics: [ComicModel]

    var body: some View {
        Group {
            if comics.isEmpty {
                SplashView()
            } else {
                HomeView()
            }
        }
        .task {
            if comics.isEmpty {
                try? await ComicsCollection.fetchComics(modelContext: modelContext)
            }
        }
    }
}
