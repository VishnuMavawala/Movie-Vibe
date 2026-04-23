//
//  Color+Extensions.swift
//  Movie Serial List
//
//  Created by Neosoft on 30/03/26.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
