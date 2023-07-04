//
//  ComicView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 8/6/2023.
//

import SwiftUI
import Kingfisher

struct ComicViewerView: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    @StateObject private var comicViewerStore: ComicViewerStore
    @EnvironmentObject private var comicFetcher: ComicFetcher
    
    init(comic: Comic) {
        _comicViewerStore = StateObject(wrappedValue: ComicViewerStore(comic: comic))
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            KFImage(URL(string: comicViewerStore.comic.image ?? ""))
                .placeholder({
                    Image("loading")
                })
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
            
            
            Spacer()
            
            ComicBottomToolbarView()
            
        }
        .navigationTitle(comicViewerStore.comic.safeTitle ?? "")
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
        .environmentObject(comicViewerStore)
    }
}

struct ComicBottomToolbarView: View {

    @EnvironmentObject var comicViewerStore: ComicViewerStore
    @EnvironmentObject private var comicFetcher: ComicFetcher
    @AppStorage("BookmarkedComicNumber") private var bookmarkedComicNumber: Int?
    @State private var diceNumber: String = ["r1", "r2", "r3", "r4", "r5", "r6"].randomElement() ?? "r1"
    @State private var isAlternativeAlertPresented = false

    var body: some View {
        HStack(spacing: 20) {
            Button {
                if let currentComicIndex = comicFetcher.comics.firstIndex(of: comicViewerStore.comic) {
                    comicViewerStore.comic = comicFetcher.comics[currentComicIndex - 1]
                }
            } label: {
                Image("prev")

            }
            .opacity(comicFetcher.comics[0].num == comicViewerStore.comic.num ? 0 : 1)

            Button {
                if bookmarkedComicNumber == comicViewerStore.comic.num {
                    bookmarkedComicNumber = nil
                } else {
                    bookmarkedComicNumber = comicViewerStore.comic.num
                }
            } label: {
                Image(bookmarkedComicNumber == comicViewerStore.comic.num ? "bookmark" : "bookmark_off")
            }

            FavoriteIconView()

            Button {
                getRandomComic()
            } label: {
                Image(diceNumber)
            }

            Button {
                isAlternativeAlertPresented = true
            } label: {
                Text("ALT")
                    .font(.xkdcFont(size: 16))
                    
            }
            .fullScreenCover(isPresented: $isAlternativeAlertPresented) {
                ZStack(alignment: .topTrailing) {
                    Text(comicViewerStore.comic.alt ?? "")
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

            Button {
                if let currentComicIndex = comicFetcher.comics.firstIndex(of: comicViewerStore.comic) {
                    comicViewerStore.comic = comicFetcher.comics[currentComicIndex + 1]
                }
            } label: {
                Image("next")

            }
            .opacity(comicViewerStore.comic.num == comicFetcher.comics[comicFetcher.comics.count - 1].num ? 0 : 1)
        }
    }

    private func getRandomComic() {
        let diceNumbers = ["r1", "r2", "r3", "r4", "r5", "r6"]

        if let randomDice = diceNumbers.randomElement() {
            diceNumber = randomDice
        }
        if let randomComic = comicFetcher.comics.randomElement() {
            comicViewerStore.comic = randomComic
        }
    }
}

struct FavoriteIconView: View {
    @EnvironmentObject var favoriteComics: FavoriteComics
    @State private var isFavorite = false
    
    @EnvironmentObject var store: ComicViewerStore
    
    var body: some View {
        Button {
            isFavorite.toggle()
            save(comic: store.comic)

        } label: {
            Image(isFavorite ? "favorite" : "favorite_off")
        }
        .onChange(of: store.comic, perform: { newValue in
            isFavorite = favoriteComics.isFavorite(comic: newValue)
        })
        .onAppear {
            isFavorite = favoriteComics.isFavorite(comic: store.comic)
        }
        .onDisappear {
            print(favoriteComics.comics)
        }
    }
    
    private func save(comic: Comic) {

        if isFavorite {
            favoriteComics.add(comic: comic)
        } else {
            favoriteComics.remove(comic: comic)
        }
    }
}
