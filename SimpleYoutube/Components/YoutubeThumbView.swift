//
//  YoutubeCoverView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import SwiftUI

struct YoutubeThumbView: View {
    private let thumbnails: Playlist.Thumbnails
    
    init(thumbnails: Playlist.Thumbnails) {
        self.thumbnails = thumbnails
    }
    
    var url: String {
        let thumbnail = thumbnails.maxres ?? thumbnails.standard ?? thumbnails.high ?? thumbnails.medium ?? thumbnails.default
        return thumbnail.url
    }
    
    var body: some View {
        URLImage(url: URL(string: url))
    }
}

struct YoutubeCoverView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeThumbView(thumbnails:
            Playlist.Thumbnails(default: Playlist.Thumbnail(url: "4HcSMGobl94", width: 0, height: 0),
                                medium: nil,
                                high: nil,
                                standard: nil,
                                maxres: nil
            )
        )
    }
}
