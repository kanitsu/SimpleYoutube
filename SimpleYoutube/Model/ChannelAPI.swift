//
//  ChannelAPI.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/4/23.
//

import Foundation
import Combine

class ChannelFetcher {
    internal let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol ChannelFetchable {
    func getPlaylist(
        forId id: String
    ) throws -> AnyPublisher<Channel, APIError>
}

extension ChannelFetcher: ChannelFetchable {
    func getPlaylist(
        forId id: String
    ) throws -> AnyPublisher<Channel, APIError> {
        var urlComp: URLComponents
        do {
            try urlComp = getChannelItem(withId: id)
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

private extension ChannelFetcher {
    func getChannelItem(
        withId id: String
    ) throws -> URLComponents {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["YOUTUBE_API_KEY"] as? String else {
            throw APIError.setting(description: "Unable to read Info.plist or YOUTUBE_API_KEY not defined in it.")
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "youtube.googleapis.com"
        components.path = "/youtube/v3/channels"
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "key", value: apiKey)
            
        ]
        //https://youtube.googleapis.com/youtube/v3/channels?part=snippet&id=UC_x5XG1OV2P6uZZ5FSM9Ttw&key=
        
        return components
    }
}
