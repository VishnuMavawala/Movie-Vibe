//
//  Movie_Serial_ListApp.swift
//  Movie Serial List
//
//  Created by Neosoft on 26/03/26.
//

import SwiftUI

@main
struct Movie_Serial_ListApp: App {
    @StateObject var watchListManager = WatchListManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(watchListManager)
        }
    }
}
