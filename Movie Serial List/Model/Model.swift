//
//  Model.swift
//  Movie Serial List
//
//  Created by Neosoft on 30/03/26.
//

enum MovieType: String {
    case trending = "Trending"
    case topRate = "Top Rate"
    case upcoming = "Upcoming"
    case search = "Searching"
    
    static var allCase: [MovieType] {
        [
            .trending,
            .topRate,
            .upcoming
        ]
    }
    
    static func getType(index: Int) -> MovieType {
        switch index {
        case 0:
            return .trending
        case 1:
            return .topRate
        case 2:
            return .upcoming
        case 3:
            return .search
        default:
            return .trending
        }
    }
}

enum Loading {
    case notLoad
    case loading
    case doneLoading
    case error(Error)
}

enum DetailsMovieType: String, CaseIterable {
    case aboutMovie = "About Movie"
    case reviews = "Reviews"
    case cast = "Cast"
    
    static func getType(index: Int) -> DetailsMovieType {
        switch index {
        case 0:
            return .aboutMovie
        case 1:
            return .reviews
        case 2:
            return .cast
        default:
            return .aboutMovie
        }
    }
}

enum NetworkError: Error {
    case badURL
    case dataInvalid
    case responseInvalid
    case decodeError
    case imageError
}

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
