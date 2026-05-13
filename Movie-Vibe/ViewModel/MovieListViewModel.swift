//
//  MovieListViewModel.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 26/03/26.
//

import Foundation
import Combine
import SwiftUI

class MovieListViewModel: ObservableObject {
    
    @Published var loading: Loading = .notLoad
    
    @Published var searchText: String = ""
    private var movieList: [MovieViewModel] = []
    @Published var searchMovieList: [MovieViewModel] = []
        
    var task: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { value in
                print("ViewModel: \(value)")
                self.searchMovie()
            }
            .store(in: &cancellables)
    }
    
    func getMovie(type: MovieType, isCancelable: Bool = false) async {
        if isCancelable {
            task?.cancel()
        }
        task = Task {
            do {
                print("calling \(Date()) - \(type.rawValue)")
                loading = .loading
                let movieList = try await MovieAPIService().fetchMovie(url: Constant.Urls.movieUrl(type), fileType: type)
                guard !(task?.isCancelled ?? true) else { return }
                
//                try await Task.sleep(nanoseconds: 3_000_000_000)
                
                self.movieList = movieList.map(MovieViewModel.init)
                searchMovie()
                loading = .doneLoading
                print("calling Responsed \(Date()) - \(type.rawValue)")
            } catch is CancellationError {
                print("Cancel Thread")
            } catch {
                print(error)
                loading = .error(error)
            }
        }
    }
    
    func searchMovie() {
        if searchText.isEmpty {
            searchMovieList = movieList
        } else {
            searchMovieList = movieList.filter({ $0.title.contains(searchText) })
        }
    }
}

struct MovieViewModel {
    let movieModel: MovieModel
    
    var id: Int {
        movieModel.id
    }
    var title: String {
        movieModel.original_title
    }
    var description: String {
        movieModel.overview
    }
    var rate: Double {
        movieModel.vote_average
    }
    var img: String {
        movieModel.poster_path
    }
    var date: String {
        movieModel.release_date
    }
    var lang: String {
        movieModel.original_language.uppercased()
    }
    var bgImage: String {
        let backdropPath = movieModel.backdrop_path ?? img
        return !backdropPath.isEmpty ? backdropPath : img 
    }
    
    static let `default` = MovieViewModel(movieModel: MovieModel(
        id: 1,
        original_title: "Spiderman No Way Home",
        overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
        vote_average: 7.8,
        poster_path: "/coJVIUEOToAEGViuhclM7pXC75R.jpg",
        backdrop_path: "/oN4TQ1TxchynXlFiXFBL3NHLT54.jpg",
        release_date: "2023-05-31",
        original_language: "en"
    ))
}
