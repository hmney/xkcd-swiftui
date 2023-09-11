//
//  ComicCodable.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 30/5/2023.
//

import Foundation

class ComicCodable: Decodable, Hashable {

    var title: String?
    var safeTitle: String?
    var alt: String?
    var image: String?
    var num: Int?
    var link: String?
    var day: String?
    var month: String?
    var year: String?
    var news: String?
    var transcript: String?
    
    enum CodingKeys: String, CodingKey {
        case title, alt, num, link, day, month, year, news, transcript
        
        case safeTitle = "safe_title"
        case image = "img"
    }
    
    static func == (lhs: ComicCodable, rhs: ComicCodable) -> Bool {
        lhs.num == rhs.num
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(num)
    }
    
}
