//
//  WatchListManager.swift
//  Movie Serial List
//
//  Created by Neosoft on 31/03/26.
//

import Foundation
import Combine

protocol WatchlistManaging {
    func add(movie: MovieModel)
    func remove(movie: MovieModel)
    func isBookmarked(movie: MovieModel) -> Bool
    var movies: [MovieModel] { get }
}

class WatchListManager: ObservableObject {
    
    @Published var movies: [MovieModel] = []
    private let key = "watchlist_movies"
    
    init() {
        load()
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let movies = try? JSONDecoder().decode([MovieModel].self, from: data) else {
            return
        }
        
        self.movies = movies
    }
    
    func toggle(movie: MovieModel) {
        if isBookmarked(movie: movie) {
            remove(movie: movie)
        } else {
            add(movie: movie)
        }
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

extension WatchListManager: WatchlistManaging {
    func add(movie: MovieModel) {
        movies.append(movie)
    }
    
    func remove(movie: MovieModel) {
        movies.removeAll(where: { $0.id == movie.id })
    }
    
    func isBookmarked(movie: MovieModel) -> Bool {
        movies.contains(where: { $0.id == movie.id })
    }
}
