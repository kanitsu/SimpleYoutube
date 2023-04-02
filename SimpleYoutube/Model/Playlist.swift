//
//  Playlist.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Foundation

struct Playlist: Codable {
    var items: [Item]
    
    struct Item: Codable {
        let resourceId: ResourceId
    }
    
    struct ResourceId: Codable {
        let videoId: String
    }
}

struct Test: Codable {
    var items: [Item]
    
    struct Item: Codable {
        let title: String
    }
}
