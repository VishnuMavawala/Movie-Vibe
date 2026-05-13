//
//  MovieAPIService.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 26/03/26.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovie(url: URL?, fileType: MovieType, searchText: String) async throws -> [MovieModel]
}

class MovieAPIService: MovieServiceProtocol {
    func fetchMovie(url: URL?, fileType: MovieType, searchText: String = "") async throws -> [MovieModel] {
        
        guard let url = url else {
            throw NetworkError.badURL
        }
        
//    #if DEBUG
//        let movieData = try getJSONData(fileType).data(using: .utf8)!
//        guard let movieList = try? JSONDecoder().decode(MovieListModel.self, from: movieData) else {
//            throw NetworkError.decodeError
//        }
//    #else
        
        var param = [Constant.Name.api_key: Constant.apiKey]
        if fileType == .search {
            param["query"] = searchText
        }
        
        print("calling - \(url)")
        let movieList: MovieListModel = try await APIClient.shared.APIResponse(url: url,
                                                                               methods: .get,
                                                                               param: param)
//    #endif
        
        return movieList.results
    }
    
    func getJSONData(_ fileType: MovieType) throws -> String {
        var fileName: String
        switch fileType {
        case .trending:
            fileName = "Trending"
        case .topRate:
            fileName = "TopRating"
        case .upcoming:
            fileName = "Upcoming"
        default:
            fileName = ""
        }
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw NetworkError.dataInvalid
        }
        return try String(contentsOf: fileURL, encoding: .utf8)
    }
}
