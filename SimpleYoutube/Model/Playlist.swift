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
