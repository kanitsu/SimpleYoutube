//
//  CommentsAPI.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine

class CommentsFetcher {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol CommentsFetchable {
    func getComments(
        forVideoId id: String,
        withToken token: String
    ) throws -> AnyPublisher<Comments, APIError>
}

extension CommentsFetcher: CommentsFetchable {
    func getComments(
        forVideoId id: String,
        withToken token: String
    ) throws -> AnyPublisher<Comments, APIError> {
        var urlComp: URLComponents
        do {
            try urlComp = getCommentsItem(forVideoId: id, withToken: token)
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

private extension CommentsFetcher {
    func getCommentsItem(
        forVideoId id: String,
        withToken token: String
    ) throws -> URLComponents {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["YOUTUBE_API_KEY"] as? String else {
            throw APIError.setting(description: "Unable to read Info.plist or YOUTUBE_API_KEY not defined in it.")
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "youtube.googleapis.com"
        components.path = "/youtube/v3/commentThreads"
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet,replies"),
            URLQueryItem(name: "videoId", value: id),
            URLQueryItem(name: "pageToken", value: token),
            URLQueryItem(name: "key", value: apiKey)
            
        ]
        //https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet%2Creplies&videoId=UJZFJar2PWY&key=
        
        return components
    }
}

