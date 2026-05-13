//
//  SearchView.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 30/03/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchListVM = SearchListViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ScrollView {
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        Section {
                            switch searchListVM.loader {
                            case .notLoad:
                                Text("Enter search text")
                                    .font(.headline)
                                    .foregroundStyle(Constant.Color.textColor)
                                    .frame(width: geo.size.width - 32, height: geo.size.height - 100)
                            case .loading:
                                ProgressView()
                                    .frame(width: geo.size.width - 32, height: geo.size.height - 100)
                            case .doneLoading:
                                if searchListVM.searchList.isEmpty {
                                    Text("No Data")
                                        .font(.headline)
                                        .foregroundStyle(Constant.Color.textColor)
                                        .frame(width: geo.size.width - 32, height: geo.size.height - 100)
                                } else {
                                    ForEach(searchListVM.searchList.enumerated(), id: \.element.id) { (index, movie) in
                                        MovieCellView(movie: movie)
                                        if index < searchListVM.searchList.count - 1 {
                                            Divider()
                                                .background(Color.white.opacity(0.5))
                                                .padding(.vertical, 4)
                                        }
                                    }
                                }
                            case .error(let error):
                                Text("No Data")
                                    .font(.headline)
//                                    .foregroundStyle(Color.orange)
                                    .foregroundStyle(Constant.Color.textColor)
                                    .frame(width: geo.size.width - 32, height: geo.size.height - 100)
                            }
                        } header: {
                            SearchBarView(text: $searchListVM.searchText)
                        }
                    }
                    .padding()
                }
                .background(Constant.Color.themeColor)
            }
        }
    }
}

#Preview {
    SearchView()
        .background(Constant.Color.themeColor)
}
