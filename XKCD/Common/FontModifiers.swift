//
//  FontModifiers.swift
//  XKCD
//
//  Created by Houssam-Eddine Mney on 4/7/2023.
//

import SwiftUI

extension Font {
    static func xkdcRegularFont(size: CGFloat) -> Font {
        Font.custom("xkcd-Regular", size: size)
    }
    
    static func xkdcFont(size: CGFloat) -> Font {
        Font.custom("xkcd", size: size)
    }
}
