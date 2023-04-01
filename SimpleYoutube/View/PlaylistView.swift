//
//  PlaylistView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI

struct PlaylistView: View {
    let videoId = "4HcSMGobl94"
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    videoBlock
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
    var videoBlock: some View {
        NavigationLink(destination: VideoView(videoId: videoId)) {
            VStack(alignment: .leading) {
                URLImage(url: URL(string: "https://img.youtube.com/vi/\(videoId)/maxresdefault.jpg"))
                VideoInfoView()
            }
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
