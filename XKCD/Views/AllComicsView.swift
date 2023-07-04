//
//  AllComicsView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import SwiftUI
import Combine
import Kingfisher

struct AllComicsView: View {
    let comics: [Comic]
    
    var body: some View {
        if comics.count > 0 {
            ComicsGridView(comics: comics,
                           viewTitle: "Comics")
        } else {
            ProgressView()
        }
    }

}



struct AllComicsView_Previews: PreviewProvider {
    static var previews: some View {
        AllComicsView(comics: [])
    }
}
