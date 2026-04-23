//
//  HomeView.swift
//  Movie Serial List
//
//  Created by Neosoft on 26/03/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject var movieListVM = MovieListViewModel()
    @StateObject var movieGridVM = MovieGridViewModel()
    @State var selectMovieIndex: Int = 0
    
    func type() -> MovieType {
        MovieType.getType(index: selectMovieIndex)
    }
    
    func textBorder(text: String, size: CGFloat) -> some View {
        ZStack(alignment: .center) {
            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.blue) // border color
                .offset(x: 1, y: 1)

            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.blue)
                .offset(x: -1, y: -1)

            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.blue)
                .offset(x: -1, y: 1)

            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.blue)
                .offset(x: 1, y: -1)

            Text(text)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(Constant.Color.themeColor)
        }
    }
    
    private func movieGrid(width: CGFloat) -> some View {
        let height = width * 1.5384615385
        print("Grid display")
        
        return ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()]) {
                ForEach(Array(movieGridVM.trendingMovieList.enumerated()), id: \.offset) { index, movie in
                    NavigationLink(destination: DetailsView(movie: movie)) {
                        ZStack(alignment: .bottomLeading) {
                            CustomeImage(imgName: movie.img)
                                .frame(height: height)
                                .aspectRatio(1.5384615385, contentMode: .fit)
                                .padding()
//                            Text("\(index + 1)")
//                                .font(.system(size: 120, weight: .heavy))
//                                .position(CGPoint(x: 30, y: height - 10))
//                                .foregroundStyle(.gray)
                            textBorder(text: "\(index + 1)", size: 120)
                                .position(CGPoint(x: 30, y: height - 10))
                                .foregroundStyle(.gray)
                        }
                        .frame(width: width, height: height)
                    }
                }
            }
        }
        .frame(height: height + 40)
        .padding(.top, -45)
        .padding(.horizontal, -16)
    }
    
    var movieList: some View {
        print("List display")
        return Group {
            if movieListVM.searchMovieList.isEmpty {
                Text("No Data")
                    .font(.headline)
                    .foregroundStyle(Constant.Color.textColor)
            } else {
                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
                    ForEach(movieListVM.searchMovieList, id: \.id) { movie in
                        NavigationLink(destination: DetailsView(movie: movie)) {
                            CustomeImage(imgName: movie.img)
                                .padding(4)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = (geo.size.width / 2) - 18
            let widthIpad = (geo.size.width / 4) - 36
            NavigationStack {
                ScrollView {
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            // MARK: - Movie Grid
                            movieGrid(width: geo.size.width > 768 ? widthIpad : width)
                            Divider()
                                .padding(.vertical, 12)
                                .padding(.horizontal, 12)
                            // MARK: - Movie List
                            VStack(alignment: .center) {
                                SegmentPickerView(segments: MovieType.allCase.map({ $0.rawValue }), selectedIndex: $selectMovieIndex)
                                    .onChange(of: selectMovieIndex) { oldValue, newValue in
                                        Task {
                                            await movieListVM.getMovie(type: type(), isCancelable: true)
                                        }
                                    }
                            }
                            // MARK: - Movie Sections
                            switch movieListVM.loading {
                            case .notLoad:
                                Text("Starting...")
                            case .loading:
                                ProgressView()
                                    .frame(width: geo.size.width - 32, height: 300)
                            case .doneLoading:
                                movieList
                                    .frame(width: geo.size.width - 32)
                            case .error(let error):
                                Text(error.localizedDescription)
                            }
                        } header: {
                            SearchBarView(text: $movieListVM.searchText)
                        }
                    }
                    .padding()
                }
                .background(Constant.Color.themeColor)
            }
            .navigationTitle("Hello")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("What do you want to watch?")
                        .font(.headline)
                }
            }
        }
        .task {
            Task {
                await movieListVM.getMovie(type: type())
            }
            
            Task {
                await movieGridVM.getTrendingMovie()
            }
        }
    }
}

#Preview {
    HomeView()
}
