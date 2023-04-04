//
//  SimpleYoutubeApp.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI

@main
struct SimpleYoutubeApp: App {
    let fetcher: PlaylistFetcher
    let playlistViewModel: PlaylistViewModel
    
    init() {
        fetcher = PlaylistFetcher()
        playlistViewModel = PlaylistViewModel(playlistFetcher: fetcher)
    }

    var body: some Scene {
        WindowGroup {
            PlaylistView(viewModel: playlistViewModel)
        }
    }
}
