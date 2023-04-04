//
//  VideoRowView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/2/23.
//

import SwiftUI

struct VideoRowView: View {
    private let viewModel: VideoRowViewModel
    
    init(viewModel: VideoRowViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: VideoView(viewModel: viewModel.createVideoViewModel())) {
                YoutubeThumbView(thumbnails: viewModel.thumbnails)
                    .frame(maxWidth: .infinity, minHeight: 240)
            }
            Spacer()
            VideoInfoView(viewModel: viewModel.createVideoViewModel())
        }
    }
}

struct VideoRowView_Previews: PreviewProvider {
    static var previews: some View {
        VideoRowView(viewModel:
            VideoRowViewModel(item:
                Playlist.Item(
                    snippet: Playlist.Snippet(
                        title: "China blocks Japan and South Korea visitors over Covid rules - BBC News",
                        publishedAt: "2023-01-10T15:12:54Z",
                        thumbnails: Playlist.Thumbnails(
                            default: Playlist.Thumbnail(
                                url: "https://i.ytimg.com/vi/y3ILgwzY0CU/default.jpg",
                                width: 120,
                                height: 00
                            ),
                            medium: nil,
                            high: nil,
                            standard: nil,
                            maxres: nil
                        ),
                        resourceId: Playlist.ResourceId(videoId: "VdL4HKqG1GM"),
                        videoOwnerChannelTitle: "BBC News",
                        videoOwnerChannelId: "UC16niRr50-MSBwiO3YDb3RA",
                        description: "China has stopped issuing short-term visas to individuals from South Korea and Japan in retaliation for Covid restrictions on Chinese travellers.\n\nVisas for South Koreans entering China have been suspended, Beijing's embassy in Seoul said, with Japanese media reporting China had imposed similar measures there.\n\nBeijing says the rule will remain in place until \"discriminatory\" entry restrictions against China are lifted.\n\nPlease subscribe HERE http://bit.ly/1rbfUog\n\n#China #Japan #SouthKorea #BBCNews"
                    )
                )
            )
        )
    }
}
