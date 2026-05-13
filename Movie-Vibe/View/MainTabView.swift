//
//  MainTabView.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 30/03/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            WatchListView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Watch list")
                }
        }
    }
}

#Preview {
    MainTabView()
}
