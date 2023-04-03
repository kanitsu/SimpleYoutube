//
//  Channel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/4/23.
//

import Foundation

struct Channel: Codable {
    var items: [Item]
    
    struct Item: Codable {
        let snippet: Snippet
    }
    
    struct Snippet: Codable {
        let thumbnails: Playlist.Thumbnails
    }
}
