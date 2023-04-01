//
//  YoutubeCoverView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import SwiftUI

struct YoutubeThumbView: View {
    let videoId: String
    
    var body: some View {
        URLImage(url: URL(string: "https://i.ytimg.com/vi/\(videoId)/maxresdefault.jpg"))
    }
}

struct YoutubeCoverView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeThumbView(videoId: "4HcSMGobl94")
    }
}
