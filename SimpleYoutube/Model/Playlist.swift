//
//  Playlist.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Foundation

struct Playlist: Codable {
    var items: [Item]
    var nextPageToken: String
    
    struct Item: Codable {
        let kind: String
        let snippet: Snippet
    }
    
    struct Snippet: Codable {
        let title: String
        let publishedAt: String
        let thumbnails: Thumbnails
        let resourceId: ResourceId
        let videoOwnerChannelTitle: String
        let videoOwnerChannelId: String
        let description: String
    }
    
    struct Thumbnails: Codable {
        let `default`: Thumbnail
        let medium: Thumbnail?
        let high: Thumbnail?
        let standard: Thumbnail?
        let maxres: Thumbnail?
    }
    
    struct Thumbnail: Codable {
        let url: String
        let width: Int
        let height: Int
    }
    
    struct ResourceId: Codable {
        let kind: String
        let videoId: String
    }
}
