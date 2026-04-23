//
//  MovieModel.swift
//  Movie Serial List
//
//  Created by Neosoft on 26/03/26.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int
    let results: [MovieModel]
    let total_pages: Int
    let total_results: Int
}

struct MovieModel: Codable {
    let id: Int
    let original_title: String
    let overview: String
    let vote_average: Double
    let poster_path: String
    let backdrop_path: String?
    let release_date: String
    let original_language: String
}
