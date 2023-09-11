//
//  BookmarkedView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI
import Kingfisher
import SwiftData

struct BookmarkedView: View {
    @Query private var comic: [ComicModel]
    
    init(bookmarkedComicNumber: Int? = nil) {
        _comic = Query(filter: #Predicate<ComicModel> { $0.num == bookmarkedComicNumber})
    }
    
    var body: some View {
        NavigationStack {
            
            Group {
                if let comic = comic.first {
                    NavigationLink {
                        ComicViewerView(comic: comic)
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        KFImage(URL(string: comic.image ?? ""))
                            .placeholder({
                                Image("loading")
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                    }
                } else {
                    Text("There's no bookmark")
                }
            }
            .navigationTitle("Bookmark")
        }
    }
}

struct BookmarkedView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkedView()
    }
}
