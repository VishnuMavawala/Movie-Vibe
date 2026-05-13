//
//  SearchListViewModel.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 30/03/26.
//

import Foundation
import Combine

class SearchListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var searchList: [MovieViewModel] = []
    @Published var loader: Loading = .notLoad
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { value in
                print("Calling API for search value")
                Task {
                    if self.searchText.isEmpty {
                        self.loader = .notLoad
                        self.searchList = []
                    } else {
                        await self.getSearch()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func getSearch() async {
        do {
            self.loader = .loading
            print("Search API starting \(searchText)...")
            let movieList = try await MovieAPIService().fetchMovie(url: Constant.Urls.movieUrl(.search), fileType: .search, searchText: searchText)
            searchList = movieList.map(MovieViewModel.init)
            print("Search API ending \(searchList.count)...")
            self.loader = .doneLoading
        } catch {
            print(error)
            self.loader = .error(error)
        }
    }
}
