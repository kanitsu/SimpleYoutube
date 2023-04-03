//
//  CommentsAPI.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine

class CommentsFetcher {
    internal let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

protocol CommentsFetchable {
    func getPlaylist(
        forId id: String,
        withToken token: String
    ) throws -> AnyPublisher<Comments, APIError>
}
