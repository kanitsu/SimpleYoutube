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
            YoutubeThumbView(videoId: viewModel.videoId)
                .frame(maxWidth: .infinity, minHeight: 240)
            }
            VideoInfoView(title: viewModel.title, owner: viewModel.owner, publishedAt: viewModel.publishedAt, photo: nil)
        }
    }
}

//struct VideoRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoRowView(viewModel:
//            VideoRowViewModel.init(item:
//                Playlist.Item(kind: "", snippet:
//                    Playlist.Snippet(title: "", publishedAt: "", thumbnails:
//                        Playlist.Thumbnails(default:
//                            Playlist.Thumbnail(url: "", width: 0, height: 0),
//                                medium: nil,
//                                high: nil,
//                                standard: nil,
//                                maxres: nil
//                        ), resourceId: Playlist.ResourceId(kind: "", videoId: "VdL4HKqG1GM")
//                    )
//                )
//            )
//        )
//    }
//}
