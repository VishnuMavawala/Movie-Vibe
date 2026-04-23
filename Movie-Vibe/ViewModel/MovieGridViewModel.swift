//
//  MovieGridViewModel.swift
//  Movie Serial List
//
//  Created by Neosoft on 03/04/26.
//

import Foundation
import Combine

class MovieGridViewModel: ObservableObject {
    
    @Published var trendingMovieList: [MovieViewModel] = []
    private var trendingProtocol: TrendingServiceProtocol
    
    init() {
        trendingProtocol = TrendingAPIService()
    }
    
    func getTrendingMovie() async {
        do {
            print("Grid calling \(Date())")
//            let movieList = try await TrendingAPIService().fetchMovie()
            
            let movieList = try await trendingProtocol.fetchMovie()
            
            let trendingMovieList = movieList.map(MovieViewModel.init)
            self.trendingMovieList = Array(trendingMovieList.shuffled().prefix(10))
            print("Grid calling Responsed \(Date())")
        } catch {
            print(error)
        }
    }
}
