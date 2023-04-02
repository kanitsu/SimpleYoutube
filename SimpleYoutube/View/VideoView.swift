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
    
    private let viewModel: VideoViewModel
    
    init(viewModel: VideoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            YoutubeVideoView(videoId: viewModel.videoId)
            VideoInfoView(title: viewModel.title, owner: viewModel.owner, publishedAt: viewModel.publishedAt, photo: nil)
            Spacer()
            Divider()
            ScrollView {
                Text(viewModel.description)
            }
            .padding(.horizontal, 10)
            Divider()
            ScrollView {
                Text("Comments")
            }
            .padding(.horizontal, 10)
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
    let title: String
    let owner: String
    let publishedAt: String
    let photo: String?
    
    var body: some View {
        HStack(alignment: .center) {
            if let photo = photo {
                Text(photo)
                Divider()
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .frame(minHeight: 40)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                Spacer()
                Divider()
                HStack(alignment: .center) {
                    Text(owner)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Divider()
                    Text(publishedAt)
                        .frame(width: 80)
                        .font(.footnote)
                        .multilineTextAlignment(.trailing)
                }
                .frame(height: 40)
            }
        }
        .padding(.horizontal, 10)
        .frame(maxHeight: 120)
    }
}

//struct VideoView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoView(videoId: "4HcSMGobl94")
//    }
//}
