//
//  BookmarkedView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI
import Kingfisher

struct BookmarkedView: View {
    @AppStorage("BookmarkedComicNumber") private var bookmarkedComicNumber: Int?
    @EnvironmentObject private var comicFetcher: ComicFetcher
    
    var body: some View {
        NavigationStack {
            
            Group {
                if let bookmarkedComicNumber, let comic = comicFetcher.comics.first(where: {$0.num == bookmarkedComicNumber}) {
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
