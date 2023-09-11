//
//  AllComicsView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI
import Combine
import Kingfisher
import SwiftData

struct AllComicsView: View {
    @Query private var comics: [ComicModel]
    
    var body: some View {
        if comics.count > 0 {
            ComicsGridView(comics: comics,
                           viewTitle: "Comics")
        } else {
            ProgressView()
        }
    }

}
