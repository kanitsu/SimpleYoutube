//
//  SimpleYoutubeApp.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI

@main
struct SimpleYoutubeApp: App {
    let persistenceController = PersistenceController.shared
    let playlistViewModel = PlaylistViewModel()

    var body: some Scene {
        WindowGroup {
            PlaylistView(viewModel: playlistViewModel)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
