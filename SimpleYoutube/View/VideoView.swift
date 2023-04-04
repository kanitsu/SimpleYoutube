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
                .frame(maxHeight: 240)
            Spacer()
            VideoInfoView(viewModel: viewModel)
                .frame(maxHeight: 110)
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
                    .frame(maxHeight: 10)
                    .font(.footnote)
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
                    .frame(maxHeight: 10)
                    .font(.footnote)
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
                    .font(.footnote)
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
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                }
            }
            .onTapGesture {
                showComment = !showComment
            }
            if !showDescription && !showComment {
                Spacer()
                    .frame(maxHeight: .infinity)
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

//struct VideoView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoView(videoId: "4HcSMGobl94")
//    }
//}
