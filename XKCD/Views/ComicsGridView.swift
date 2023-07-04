//
//  ComicsGridView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 22/6/2023.
//

import SwiftUI
import Kingfisher

struct ComicsGridView: View {
    private let comicsWithOddNumber: [Comic]
    private let comicsWithEvenNumber: [Comic]
    let viewTitle: String
    
    @State private var searchText = ""


    init(comics: [Comic], viewTitle: String) {
        self.comicsWithOddNumber = ComicsGridView.convertComicsList(comics).0
        self.comicsWithEvenNumber = ComicsGridView.convertComicsList(comics).1
        self.viewTitle = viewTitle
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : UIFont(name: "xkcd-Regular", size: 40)!
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name: "xkcd-Regular", size: 20)!
        ]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                HStack(alignment: .top) {
                    LazyVStack(spacing: 10) {
                        ForEach(comicsWithEvenNumber, id:\.self){ comic in
                            ComicGridItemView(comic: comic)
                        }
                    }
                    LazyVStack(spacing: 10) {
                        ForEach(comicsWithOddNumber, id:\.self){ comic in
                            ComicGridItemView(comic: comic)
                                .onAppear {
                                    print(comic.num!)
                                }
                        }
                    }
                    
                }
                .navigationDestination(for: Comic.self) { comic in
                    ComicViewerView(comic: comic)
                        .toolbar(.hidden, for: .tabBar)
                }
                .navigationTitle(viewTitle)
                .bold()
                .padding()
            }
        }
        .searchable(text: $searchText, prompt: "Look for comic")

    }
    
    private func imageDimensions(url: String) -> (Int, Int)? {
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return (pixelWidth, pixelHeight)
            }
        }
        return nil
    }
    
    private static func convertComicsList(_ comics: [Comic]) -> ([Comic], [Comic]) {
        var oddList = [Comic]()
        var evenList = [Comic]()
        let length = comics.count % 2 == 0 ? comics.count : comics.count - 1
        for i in 0..<length{
            if i % 2 == 0 {
                evenList.append(comics[i])
            } else {
                oddList.append(comics[i])
            }
        }
        if length != comics.count {
            evenList.append(comics[length])
        }
        return (oddList, evenList)
    }
    
    
}

struct ComicGridItemView: View {
    let comic: Comic
    
    var body: some View {
        NavigationLink(value: comic) {
            ZStack(alignment: .bottomTrailing) {
                KFImage(URL(string: comic.image ?? ""))
                    .placeholder({
                        Image("loading")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    })
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                ComicNumberView(number: Int(comic.num ?? -1))
                
            }
        }
    }
}

struct ComicNumberView: View {
    let number: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.teal)
            Text(number.description)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(2)
    }
}

//struct ComicNumberView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicNumberView(number: 1234)
//    }
//}
//
//struct ComicsGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicsGridView(comics: [], viewTitle: "")
//    }
//}
