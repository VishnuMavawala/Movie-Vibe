//
//  WatchListManager.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 31/03/26.
//

import Foundation
import Combine

/// Protocol defining the interface for managing a watchlist of movies.
protocol WatchlistManaging {
    func add(movie: MovieModel)
    func remove(movie: MovieModel)
    func isBookmarked(movie: MovieModel) -> Bool
    var movies: [MovieModel] { get }
}

/// A manager class that handles the persistence and state of the user's movie watchlist.
/// Uses UserDefaults for simple local storage.
class WatchListManager: ObservableObject {
    
    /// The current list of bookmarked movies, published for UI updates.
    @Published var movies: [MovieModel] = []
    private let key = "watchlist_movies"
    
    init() {
        load()
    }
    
    /// Loads the watchlist from UserDefaults.
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let movies = try? JSONDecoder().decode([MovieModel].self, from: data) else {
            return
        }
        
        self.movies = movies
    }
    
    /// Toggles a movie's presence in the watchlist.
    /// - Parameter movie: The movie to add or remove.
    func toggle(movie: MovieModel) {
        if isBookmarked(movie: movie) {
            remove(movie: movie)
        } else {
            add(movie: movie)
        }
        save()
    }
    
    /// Saves the current state of the watchlist to UserDefaults.
    private func save() {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

extension WatchListManager: WatchlistManaging {
    /// Adds a movie to the watchlist.
    func add(movie: MovieModel) {
        movies.append(movie)
    }
    
    /// Removes a movie from the watchlist by ID.
    func remove(movie: MovieModel) {
        movies.removeAll(where: { $0.id == movie.id })
    }
    
    /// Checks if a movie is already in the watchlist.
    func isBookmarked(movie: MovieModel) -> Bool {
        movies.contains(where: { $0.id == movie.id })
    }
}
