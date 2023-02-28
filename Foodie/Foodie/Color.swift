//
//  Color.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import Foundation
import SwiftUI

extension Color {
    static var primaryColor: Color {
        Color.purple
    }
}

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.10, green: 0.13, blue: 0.16)
    }
    
    static var elevatedBackground: Color {
        Color(red: 0.07, green: 0.10, blue: 0.14)
    }
}

