//
//  CommentRowViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation

struct CommentRowViewModel: Identifiable {
    private let comment: Comments.Comment
    private let replyComments: [Comments.Comment]?
    
    init(comment: Comments.Comment, replyComments: [Comments.Comment]? = nil) {
        self.comment = comment
        self.replyComments = replyComments
    }
    
    var id: String {
        return comment.id
    }
    
    var content: String {
        return comment.snippet.textOriginal
    }
    
    var author: String {
        return comment.snippet.authorDisplayName
    }
    
    var photoUrl: String {
        return comment.snippet.authorProfileImageUrl
    }
    
    var updatedAt: String {
        return reformatDate(input: comment.snippet.updatedAt)
    }
    
    var replyViewModels: [CommentRowViewModel]? {
        return replyComments?.map({ CommentRowViewModel(comment: $0) })
    }
}

extension CommentRowViewModel: Hashable {
  static func == (lhs: CommentRowViewModel, rhs: CommentRowViewModel) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
