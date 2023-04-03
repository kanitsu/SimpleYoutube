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
    
    @State private var showDescription = true
    @State private var showComment = true
    
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
            VStack(alignment: .center) {
                if showDescription {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Tap to hide description")
                        Image(systemName: "chevron.up")
                        Spacer()
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    ScrollView {
                        Text(viewModel.description)
                    }
                        .padding(.horizontal, 10)
                } else {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Tap to show description")
                        Image(systemName: "chevron.down")
                        Spacer()
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                }
            }
            .onTapGesture {
                showDescription = !showDescription
            }
            Divider()
            VStack(alignment: .center) {
                if showComment {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Tap to hide comments")
                        Image(systemName: "chevron.up")
                        Spacer()
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    CommentsView(viewModel: CommentsViewModel(videoId: viewModel.videoId))
                        .padding(.horizontal, 10)
                } else {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Tap to show comments")
                        Image(systemName: "chevron.down")
                        Spacer()
                    }
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                }
            }
            .onTapGesture {
                showComment = !showComment
            }
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
