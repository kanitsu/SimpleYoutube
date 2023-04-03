//
//  VideoInfoView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/4/23.
//

import SwiftUI

struct VideoInfoView: View {
    @ObservedObject var viewModel: VideoViewModel
    
    init(viewModel: VideoViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if let photo = viewModel.photoUrl {
                URLImage(url: URL(string: photo))
                    .frame(width: 60)
                Divider()
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(viewModel.title)
                    .frame(minHeight: 40)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                Spacer()
                Divider()
                HStack(alignment: .center) {
                    Text(viewModel.owner)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Divider()
                    Text(viewModel.publishedAt)
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

//struct VideoInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoInfoView()
//    }
//}
