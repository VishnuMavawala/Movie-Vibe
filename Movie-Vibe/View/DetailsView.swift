//
//  DetailsView.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 27/03/26.
//

import SwiftUI

struct DetailsView: View {
    let movie: MovieViewModel
    @State var selectedDetailsIndex: Int = 0
    @EnvironmentObject var watchListManager: WatchListManager
    
    var bottomShadowVw: some View {
        // Bottom Shadow
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.5), .clear]),
                startPoint: .bottom,
                endPoint: .top
            ))
            .frame(height: 80)
            .cornerRadius(24)
    }
    
    var ratingVw: some View {
        HStack {
            Image(systemName: "star")
            Text(String(format: "%.1f", movie.rate))
                .fontWeight(.medium)
        }
        .padding(8)
        .foregroundStyle(Color.orange)
        .background(Color.black.opacity(0.4))
        .background(Color.gray.opacity(0.8))
        .cornerRadius(12)
        .padding()
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack() {
                    // MARK: - Movie Bg and Rating
                        ZStack(alignment: .bottomTrailing, content: {
                            CustomeImage(imgName: movie.bgImage)
                                .scaledToFill()
                                .frame(width: geo.size.width, height: 300)
                            bottomShadowVw
                            ratingVw
                        })
                    .clipped()
                    
                    VStack(spacing: 24) {
                        // MARK: - Main picture
                        HStack(alignment: .center, spacing: 12) {
                            CustomeImage(imgName: movie.img)
                                .frame(width: 130, height: 200)
                                .padding(.top, -100)
                            
                            Text(movie.title)
                                .font(.system(size: 24, weight: .heavy))
                                .foregroundStyle(Constant.Color.textColor)
                        }
                        
                        // MARK: - Other Info
                        HStack(spacing: 10) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(movie.date)
                            }
                            Divider()
                                .background(Color.white.opacity(0.5))
                            HStack {
                                Image(systemName: "clock")
                                Text("148 Minutes")
                            }
                            Divider()
                                .background(Color.white.opacity(0.5))
                            HStack {
                                Image(systemName: "ticket")
                                Text(movie.lang)
                            }
                        }
                        .foregroundStyle(Color.gray)
                        
                        // MARK: - Segment Details
                        LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                            Section {
                                switch DetailsMovieType.getType(index: selectedDetailsIndex) {
                                case .aboutMovie:
                                    // MARK: - About Movie
                                    Text(movie.description)
                                        .font(.subheadline)
                                        .foregroundStyle(Constant.Color.textColor)
                                case .reviews:
                                    // MARK: - Reviews
                                    ForEach(Array(1...10).enumerated(), id: \.element) { index, data in
                                        VStack {
                                            HStack(alignment: .top) {
                                                VStack {
                                                    Image(systemName: "person.circle.fill")
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                        .foregroundStyle(Color.random)
                                                    Text("6.3")
                                                        .foregroundStyle(Color.blue)
                                                }
                                                VStack(alignment: .leading) {
                                                    Text("Iqbal Shafiq Rozaan")
                                                        .fontWeight(.medium)
                                                        .foregroundStyle(Constant.Color.textColor)
                                                    Text("From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government.")
                                                        .foregroundStyle(Constant.Color.textColor)
                                                }
                                            }
                                            
                                            if index < 9 {
                                                Divider()
                                                    .background(Color.white.opacity(0.5))
                                                    .padding(.vertical, 4)
                                            }
                                        }
                                    }
                                case .cast:
                                    // MARK: - Cast
                                    let columns = [GridItem(), GridItem()]
                                    LazyVGrid(columns: columns, spacing: 12) {
                                        ForEach(1...10, id: \.self) { _ in
                                            VStack(spacing: 16) {
                                                Image(systemName: "person.circle")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .foregroundStyle(Color.random)
                                                Text("Name")
                                                    .font(.title3)
                                                    .foregroundStyle(Constant.Color.textColor)
                                            }
                                        }
                                    }
                                }
                            } header: {
                                SegmentPickerView(segments: DetailsMovieType.allCases.map({ $0.rawValue }), selectedIndex: $selectedDetailsIndex)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Constant.Color.themeColor)
        }
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    watchListManager.toggle(movie: movie.movieModel)
                }) {
                    Image(systemName: watchListManager.isBookmarked(movie: movie.movieModel) ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color("OppositeThemeColor"))
                }
            }
        }
    }
}

#Preview {
    DetailsView(movie: MovieViewModel.default)
        .environmentObject(WatchListManager())
}
