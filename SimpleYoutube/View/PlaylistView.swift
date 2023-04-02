//
//  PlaylistView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI

struct PlaylistView: View {
    @ObservedObject var viewModel: PlaylistViewModel
    
    init(viewModel: PlaylistViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.dataSource, content: VideoRowView.init(viewModel:))
                }
            }
            .navigationBarTitle(Text("Simple Youtube"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // Handle button tap
                }) {
                    Image(systemName: "magnifyingglass")
                }
            )
        }
    }
}

private extension PlaylistView {
}

//struct PlaylistView_Previews: PreviewProvider {
//    let fetcher: PlaylistFetcher
//    let playlistViewModel: PlaylistViewModel
//
//    init() {
//        fetcher = PlaylistFetcher()
//        playlistViewModel = PlaylistViewModel(playlistFetcher: fetcher)
//    }
//
//    static var previews: some View {
//        PlaylistView(viewModel: playlistViewModel)
//    }
//}
