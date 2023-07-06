//
//  ComicViewerStore.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 4/7/2023.
//

import Foundation

@MainActor
class ComicViewerStore: ObservableObject {
    @Published var comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
    }
}

