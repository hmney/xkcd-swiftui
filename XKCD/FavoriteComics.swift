//
//  FavoriteComics.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 4/7/2023.
//

import Foundation

@MainActor
class FavoriteComics: ObservableObject {
    @Published var comics: [Comic] = []
    
    var isEmpty: Bool {
        return comics.count == 0
    }
    
    func add(comic: Comic) {
        if !comics.contains(comic) {
            comics.append(comic)
        }
    }
    
    func remove(comic: Comic) {
        if let index = comics.firstIndex(of: comic) {
            comics.remove(at: index)
        }
    }
    
    func isFavorite(comic: Comic) -> Bool {
        return comics.firstIndex(of: comic) != nil ? true : false
    }
    
}
