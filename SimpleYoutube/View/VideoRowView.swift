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
        NavigationLink(destination: VideoView(videoId: viewModel.code)) {
            VStack(alignment: .leading) {
                YoutubeThumbView(videoId: viewModel.code)
                    .frame(maxWidth: .infinity, minHeight: 240)
                VideoInfoView()
            }
        }
    }
}

struct VideoRowView_Previews: PreviewProvider {
    static var previews: some View {
        VideoRowView(viewModel: VideoRowViewModel.init(item: Playlist.Item(code: "VdL4HKqG1GM")))
    }
}
