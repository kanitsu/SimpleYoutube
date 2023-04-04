//
//  CommentView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import SwiftUI

struct CommentRowView: View {
    private let viewModel: CommentRowViewModel
    
    init(viewModel: CommentRowViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        CommentInnerRowView(viewModel: viewModel)
        if viewModel.replyViewModels != nil {
            ForEach(viewModel.replyViewModels!, content: CommentReplyRowView.init(viewModel:))
        }
        Divider()
    }
}

private struct CommentReplyRowView: View {
    private let viewModel: CommentRowViewModel
    
    init(viewModel: CommentRowViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(alignment: .top) {
                Spacer()
                CommentInnerRowView(viewModel: viewModel)
            }
            Image(systemName: "arrowshape.turn.up.left.fill")
                .foregroundColor(.red)
                .position(x: 10, y: 10)
        }
    }
}

private struct CommentInnerRowView: View {
    private let viewModel: CommentRowViewModel
    
    init(viewModel: CommentRowViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            URLImage(url: URL(string: viewModel.photoUrl))
                .frame(width: 60)
            Divider()
            VStack(alignment: .leading) {
                Text(viewModel.author)
                    .bold()
                Spacer()
                Text(viewModel.content)
                Spacer()
                HStack {
                    Spacer()
                    Text(viewModel.updatedAt)
                }
                .font(.footnote)
            }
            .padding(.leading, 5)
            Spacer()
        }
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(viewModel: CommentRowViewModel(comment: Comments.Comment(
            id: "",
            snippet: Comments.CommentDetail(
                textOriginal: "This is another example of Chinese tit-for-tat. The Chinese Communist Party is behind this political propaganda",
                authorDisplayName: "Roger",
                authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJUSYdxwjy6Lh62yfDGq2avWRKwV-tQH2DVzGw=s48-c-k-c0x00ffffff-no-rj",
                updatedAt: "2023-03-02T17:36:21Z"
            )
        )))
    }
}
