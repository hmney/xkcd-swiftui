//
//  ComicsGridView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 22/6/2023.
//

import SwiftUI
import Kingfisher

struct ComicsGridView: View {
    let viewTitle: String
    
    @State private var searchText = ""
    private var comics: [ComicModel]

    init(comics: [ComicModel], viewTitle: String) {
        self.comics = comics
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
                        ForEach(comics.filter({ $0.num! % 2 == 0 }), id: \.self) { comic in
                            ComicGridItemView(comic: comic)
                        }
                    }
                    LazyVStack(spacing: 10) {
                        ForEach(comics.filter({ $0.num! % 2 != 0 }), id: \.self) { comic in
                            ComicGridItemView(comic: comic)
                        }
                    }
                    
                }
                .navigationDestination(for: ComicModel.self) { comic in
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
    
}

struct ComicGridItemView: View {
    let comic: ComicModel
    
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
