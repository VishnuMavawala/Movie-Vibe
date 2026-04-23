//
//  Constant.swift
//  Movie Serial List
//
//  Created by Neosoft on 26/03/26.
//

import Foundation
import SwiftUI

struct Constant {
    
    static let apiKey = "a8a2b203c561ef9bfe7ce76e69f8a32b"
    
    struct Color {
        static let themeColor = SwiftUI.Color("Theme")
        static let textColor = SwiftUI.Color.white
    }
    
    struct Name {
        static let api_key = "api_key"
        
    }
    
    struct Urls {
        private static let baseURL = "https://api.themoviedb.org/3/"
        static func imgUrl(_ name: String) -> URL? {
            URL(string: "https://image.tmdb.org/t/p/w500\(name)")
        }
        static func movieUrl(_ type: MovieType) -> URL? {
            switch type {
            case .trending:
                URL(string: "\(baseURL)trending/movie/day")
            case .topRate:
                URL(string: "\(baseURL)movie/top_rated")
            case .upcoming:
                URL(string: "\(baseURL)movie/upcoming")
            case .search:
                URL(string: "\(baseURL)search/movie")
            }
        }
    }
}
