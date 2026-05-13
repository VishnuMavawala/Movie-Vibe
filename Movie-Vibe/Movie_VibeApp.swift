//
//  Movie_VibeApp.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 26/03/26.
//

import SwiftUI

/// The main entry point for the Movie-Vibe application.
/// It initializes the global WatchListManager and sets up the root view.
@main
struct Movie_VibeApp: App {
    @StateObject var watchListManager = WatchListManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(watchListManager)
        }
    }
}
