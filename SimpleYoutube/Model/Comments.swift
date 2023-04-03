//
//  Comments.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation

struct Comments: Codable {
    var items: [Item]
    var nextPageToken: String?
    
    struct Item: Codable {
        let snippet: Snippet
        let replies: Replies?
    }
    
    struct Snippet: Codable {
        let topLevelComment: Comment
    }
    
    struct Replies: Codable {
        let comments: [Comment]
    }
    
    struct Comment: Codable {
        let id: String
        let snippet: CommentDetail
    }
    
    struct CommentDetail: Codable {
        let textOriginal: String
        let authorDisplayName: String
        let authorProfileImageUrl: String
        let updatedAt: String
    }
}
