//
//  ComicsService.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 3/6/2023.
//

import Foundation
import SwiftData

class ComicsCollection {

    private static let comicOfTheDayURL = "https://xkcd.com/info.0.json"
    private static let comicByIdURL = "https://xkcd.com/:id/info.0.json"
    
    @MainActor
    static func fetchComics(with limitOf: Int? = nil, modelContext: ModelContext) async throws {
        
        guard let firstComic = try await fetchComic(withID: 0) else { return }
                
        guard let numberOfComics = firstComic.num else { return }
        
        save(firstComic, modelContext: modelContext)
        
        for id in 1..<(limitOf ?? numberOfComics) {
            guard let comic = try await self.fetchComic(withID: numberOfComics - id) else { return }
            save(comic, modelContext: modelContext)
        }
        
    }
    
    static func fetchComic(withID id: Int) async throws -> ComicCodable? {
        let urlString = id > 0
        ? comicByIdURL.replacingOccurrences(of: ":id", with: String(id))
        : comicOfTheDayURL
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode( ComicCodable.self, from: data)
            
            return decodedData
        } catch let error {
            print(error)
            return nil
        }
    }
    
    private static func save(_ comic: ComicCodable, modelContext: ModelContext) {
        let newComic = ComicModel(title: comic.title, safeTitle: comic.safeTitle, alt: comic.alt, image: comic.image, num: comic.num, link: comic.link, day: comic.day, month: comic.month, year: comic.year, news: comic.news, transcript: comic.transcript)
        modelContext.insert(newComic)
    }
    
}
