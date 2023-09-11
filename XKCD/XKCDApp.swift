//
//  XKCDApp.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 29/5/2023.
//

import SwiftUI
import SwiftData

@main
struct XKCDApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ComicModel.self)
    }
}
