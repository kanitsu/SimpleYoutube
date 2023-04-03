//
//  PlaylistAPI.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine

class PlaylistFetcher {
    internal let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol PlaylistFetchable {
    func getPlaylist(
        forId id: String,
        withLimit limit: Int,
        andToken token: String
    ) throws -> AnyPublisher<Playlist, APIError>
}

extension PlaylistFetcher: PlaylistFetchable {
    func getPlaylist(
        forId id: String,
        withLimit limit: Int,
        andToken token: String
    ) throws -> AnyPublisher<Playlist, APIError> {
        var urlComp: URLComponents
        do {
            try urlComp = getPlaylistItem(withId: id, withLimit: limit, andToken: token)
        } catch {
            throw error
        }
        
//        if let url = urlComp.url {
//            let urlString = url.absoluteString
//            print("Full URL: \(urlString)")
//        }
        
        return fetch(with: session, andComponents: urlComp)
    }
}

private extension PlaylistFetcher {
    func getPlaylistItem(
        withId id: String,
        withLimit limit: Int,
        andToken token: String
    ) throws -> URLComponents {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["YOUTUBE_API_KEY"] as? String else {
            throw APIError.setting(description: "Unable to read Info.plist or YOUTUBE_API_KEY not defined in it.")
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "youtube.googleapis.com"
        components.path = "/youtube/v3/playlistItems"
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "maxResults", value: String(limit)),
            URLQueryItem(name: "playlistId", value: id),
            URLQueryItem(name: "pageToken", value: token),
            URLQueryItem(name: "key", value: apiKey)
            
        ]
        //https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet%2Cstatus&maxResults=30&playlistId=PLF4D8851BA7D9DA6E&key=
        
        return components
    }
}
