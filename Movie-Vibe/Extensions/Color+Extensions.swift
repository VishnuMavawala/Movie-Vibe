//
//  Color+Extensions.swift
//  Movie-Vibe
//
//  Created by Neosoft on 30/03/26.
//

import SwiftUI

extension Color {
    /// Generates a random color.
    /// Useful for placeholder backgrounds or decorative elements.
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
