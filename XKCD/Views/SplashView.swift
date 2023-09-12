//
//  ContentView.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 29/5/2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
   
    var body: some View {
        VStack {
            Image("splash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding([.leading, .trailing], 20)
            
            ProgressView()
            Text("Data Loading ...")
                .padding()
            
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
