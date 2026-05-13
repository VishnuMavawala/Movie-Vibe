//
//  WatchListView.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 31/03/26.
//

import SwiftUI

struct WatchListView: View {
    @EnvironmentObject var watchListManager: WatchListManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(Array(watchListManager.movies.enumerated()), id: \.element.id) { index, movie in
                        let movieVM = MovieViewModel(movieModel: movie)
                        MovieCellView(movie: movieVM)
                        if index < watchListManager.movies.count - 1 {
                            Divider()
                                .background(Color.white.opacity(0.5))
                                .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
            }
            .background(Constant.Color.themeColor)
        }
    }
}

#Preview {
    WatchListView()
        .environmentObject(WatchListManager())
        .background(Constant.Color.themeColor)
}
