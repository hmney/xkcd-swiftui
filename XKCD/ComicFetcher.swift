//
//  ComicsService.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 3/6/2023.
//

import Foundation

@MainActor
class ComicFetcher: ObservableObject {
    
    @Published var comics: [Comic] = []

    private let comicOfTheDayURL = "https://xkcd.com/info.0.json"
    private let comicByIdURL = "https://xkcd.com/:id/info.0.json"
    
    func fetchComics(with limitOf: Int? = nil) async throws {
        
        guard let firstComic = try await fetchComic(withID: 0) else { return }
                
        guard let numberOfComics = firstComic.num else { return }
        
        comics.append(firstComic)
        
        for id in 1..<(limitOf ?? numberOfComics) {
            guard let comic = try await self.fetchComic(withID: numberOfComics - id) else { return }
            comics.append(comic)
        }
        
    }
    
    func fetchComic(withID id: Int) async throws -> Comic? {
        let urlString = id > 0
        ? comicByIdURL.replacingOccurrences(of: ":id", with: String(id))
        : comicOfTheDayURL
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode( Comic.self, from: data)
            print(response)

            return decodedData
        } catch let error {
            print(error)
            return nil
        }
        

        
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("newComics.data")
    }
    
    func loadComics() async throws {
        let task = Task<[Comic], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            
            let comics = try JSONDecoder().decode([Comic].self, from: data)
            return comics
        }
        
        let comics = try await task.value
        self.comics = comics
        
    }

    func save(comics: [Comic]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(comics)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
