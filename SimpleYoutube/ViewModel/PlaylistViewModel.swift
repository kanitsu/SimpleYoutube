//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Combine
import Foundation

class PlaylistViewModel: ObservableObject {
    @Published var dataSource: [VideoRowViewModel] = []
    
    init() {
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "VdL4HKqG1GM")))
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "wcjjw_u7ogo")))
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "VVis4k49UW8")))
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "XLw8P9VKETw")))
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "8hPJSTiNjok")))
        dataSource.append(VideoRowViewModel.init(item: Playlist.Item(code: "XQkZdBJ-sOY")))
    }
}
