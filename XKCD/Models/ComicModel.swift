//
//  ComicModel.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 10/9/2023.
//

import SwiftData

@Model
class ComicModel {
    
    @Attribute(.unique) var num: Int?
    var title: String?
    var safeTitle: String?
    var alt: String?
    var image: String?
    var link: String?
    var day: String?
    var month: String?
    var year: String?
    var news: String?
    var transcript: String?
    var isFavorited: Bool = false
    
    init(title: String? = nil, safeTitle: String? = nil, alt: String? = nil, image: String? = nil, num: Int? = nil, link: String? = nil, day: String? = nil, month: String? = nil, year: String? = nil, news: String? = nil, transcript: String? = nil) {
        self.title = title
        self.safeTitle = safeTitle
        self.alt = alt
        self.image = image
        self.num = num
        self.link = link
        self.day = day
        self.month = month
        self.year = year
        self.news = news
        self.transcript = transcript
    }
    
}
