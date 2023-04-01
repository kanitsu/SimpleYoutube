//
//  VideoView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI
import WebKit

struct VideoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let videoId: String
    
    var body: some View {
        VStack(alignment: .leading) {
            YoutubeVideoView(videoId: videoId)
            VideoInfoView()
            Text("Video Details")
            Text("Comments")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                Text("Playlist")
            }
        }
    }
}

struct VideoInfoView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Author Photo")
            VStack(alignment: .leading) {
                Text("Video Title")
                HStack(alignment: .center) {
                    Text("Author Name")
                    Text("Upload Date")
                }
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoId: "4HcSMGobl94")
    }
}
