//
//  ComicView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 8/6/2023.
//

import SwiftUI
import Kingfisher
import SwiftData

struct ComicViewerView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    @State private var comic: ComicModel
    
    init(comic: ComicModel) {
        _comic = State(wrappedValue: comic)
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            KFImage(URL(string: comic.image ?? ""))
                .placeholder({
                    Image("loading")
                })
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
            
            
            Spacer()
            
            ComicBottomToolbarView(comic: $comic)
            
        }
        .navigationTitle(comic.safeTitle ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("back")
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // share comic later
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                
            }
        }
    }
}

struct ComicBottomToolbarView: View {
    @Query var comics: [ComicModel]
    @Binding var comic: ComicModel
 
    var body: some View {
        HStack(spacing: 20) {
            PreviousButtonView(comics: comics, comic: $comic)

            BookmarkButtonView(comic: comic)

            FavoriteButtonView(comic: comic)
            
            RandomButtonView(comics: comics, comic: $comic)
            
            AltButtonView(comic: comic)

            NextButtonView(comics: comics, comic: $comic)
        }
    }
}

struct PreviousButtonView: View {
    var comics: [ComicModel]
    @Binding var comic: ComicModel
    
    var body: some View {
        Button {
            if let curr = comics.firstIndex(of: comic) {
                comic = comics[curr - 1]
            }
        } label: {
            Image("prev")

        }
        .opacity(comic == comics.first ? 0 : 1)
    }
}

struct BookmarkButtonView: View {
    var comic: ComicModel
    @AppStorage("BookmarkedComicNumber") private var bookmarkedComicNumber: Int?

    var body: some View {
        Button {
            if bookmarkedComicNumber == comic.num {
                bookmarkedComicNumber = nil
            } else {
                bookmarkedComicNumber = comic.num
            }
        } label: {
            Image(bookmarkedComicNumber == comic.num ? "bookmark" : "bookmark_off")
        }
    }
}

struct RandomButtonView: View {
    var comics: [ComicModel]
    @State private var diceNumber: String = ["r1", "r2", "r3", "r4", "r5", "r6"].randomElement() ?? "r1"
    @Binding var comic: ComicModel

    var body: some View {
        Button {
            getRandomComic()
        } label: {
            Image(diceNumber)
        }
    }
    
    private func getRandomComic() {
        let diceNumbers = ["r1", "r2", "r3", "r4", "r5", "r6"]

        if let randomDice = diceNumbers.randomElement() {
            diceNumber = randomDice
        }
        
        if let randomComic = comics.randomElement() {
            comic = randomComic
        }
    }
}

struct FavoriteButtonView: View {
    var comic: ComicModel
    
    var body: some View {
        Button {
            comic.isFavorited.toggle()
        } label: {
            Image(comic.isFavorited ? "favorite" : "favorite_off")
        }
    }
}

struct AltButtonView: View {
    var comic: ComicModel
    @State private var isAlternativeAlertPresented = false

    var body: some View {
        Button {
            isAlternativeAlertPresented = true
        } label: {
            Text("ALT")
                .font(.xkdcFont(size: 16))
                
        }
        .fullScreenCover(isPresented: $isAlternativeAlertPresented) {
            ZStack(alignment: .topTrailing) {
                Text(comic.alt ?? "")
                    .font(.xkdcFont(size: 16))
                    .padding()
                    .background(.white)
                Button {
                    isAlternativeAlertPresented.toggle()

                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.black)
                        .padding(2)
                }

            }
            .padding()
            .presentationBackground {
                Color.black.opacity(0.8)
            }

        }
    }
}

struct NextButtonView: View {
    var comics: [ComicModel]
    @Binding var comic: ComicModel
    
    var body: some View {
        Button {
            if let curr = comics.firstIndex(of: comic) {
                comic = comics[curr + 1]
            }
        } label: {
            Image("next")

        }
        .opacity(comic == comics.last ? 0 : 1)
    }
}
