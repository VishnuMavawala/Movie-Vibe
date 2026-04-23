//
//  TrandingAPIService.swift
//  Movie Serial List
//
//  Created by Neosoft on 03/04/26.
//

protocol TrendingServiceProtocol {
    func fetchMovie() async throws -> [MovieModel]
}

class TrendingAPIService: TrendingServiceProtocol {
    func fetchMovie() async throws -> [MovieModel] {
        
        guard let url = Constant.Urls.movieUrl(.trending) else {
            throw NetworkError.badURL
        }
        
        let param = [Constant.Name.api_key: Constant.apiKey]
        print("calling - \(url)")
        let movieList: MovieListModel = try await APIClient.shared.APIResponse(url: url,
                                                                               methods: .get,
                                                                               param: param)
        
        return movieList.results
    }
}
