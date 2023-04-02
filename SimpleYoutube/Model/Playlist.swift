//
//  Playlist.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Foundation

struct Playlist: Codable {
    var list: [Item]
    
    struct Item: Codable {
        let code: String
    }
}

struct Test: Codable {
    var items: [Item]
    
    struct Item: Codable {
        let title: String
        let cover: String
        let play_url: String
    }
}
