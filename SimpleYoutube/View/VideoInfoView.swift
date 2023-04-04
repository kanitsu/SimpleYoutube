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

struct VideoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoInfoView(
            viewModel: VideoViewModel(data: VideoViewModel.VideoData(
                videoId: "y3ILgwzY0CU",
                title: "China blocks Japan and South Korea visitors over Covid rules - BBC News",
                owner: "BBC News",
                publishedAt: "2023-01-10 23:12:54",
                description: "China has stopped issuing short-term visas to individuals from South Korea and Japan in retaliation for Covid restrictions on Chinese travellers.\n\nVisas for South Koreans entering China have been suspended, Beijing's embassy in Seoul said, with Japanese media reporting China had imposed similar measures there.\n\nBeijing says the rule will remain in place until \"discriminatory\" entry restrictions against China are lifted.\n\nPlease subscribe HERE http://bit.ly/1rbfUog\n\n#China #Japan #SouthKorea #BBCNews",
                ownerId: "UC16niRr50-MSBwiO3YDb3RA"
            ))
        )
    }
}
