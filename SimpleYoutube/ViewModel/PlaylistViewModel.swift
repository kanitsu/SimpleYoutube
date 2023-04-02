//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Combine
import Foundation
import os.log

class PlaylistViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var dataSource: [VideoRowViewModel] = []
    
    private let playlistFetcher: PlaylistFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(
        playlistFetcher: PlaylistFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "PlaylistViewModel")
    ) {
        self.playlistFetcher = playlistFetcher
        fetchPlaylist(forId: id)
    }
    
    func fetchPlaylist(forId id: String) {
        playlistFetcher.getPlaylist(forId: id)
//            .map { response in
//                response.list.map(VideoRowViewModel.init)
//            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure:
                            self.dataSource = []
                        case .finished:
                            break
                    }
                }, receiveValue: { [weak self] playlist in
                    guard let self = self else { return }
                    //self.dataSource = playlist
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "VdL4HKqG1GM"))))
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "wcjjw_u7ogo"))))
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "VVis4k49UW8"))))
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "XLw8P9VKETw"))))
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "8hPJSTiNjok"))))
                    self.dataSource.append(VideoRowViewModel.init(item: Playlist.Item(resourceId: Playlist.ResourceId(videoId: "XQkZdBJ-sOY"))))
                }
            )
            .store(in: &disposables)
    }
}

protocol PlaylistFetchable {
    func getPlaylist(
        forId id: String
    ) -> AnyPublisher<Test, PlaylistError>
}

class PlaylistFetcher {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension PlaylistFetcher: PlaylistFetchable {
    func getPlaylist(
        forId id: String
    ) -> AnyPublisher<Test, PlaylistError> {
        return fetch(with: getPlaylistItem(withId: id))
    }
    
    private func fetch<T>(
      with components: URLComponents
    ) -> AnyPublisher<T, PlaylistError> where T: Decodable {
        guard let url = components.url else {
            let error = PlaylistError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension PlaylistFetcher {
    func getPlaylistItem(
        withId id: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 3000
        components.path = "/following_list"
        components.queryItems = [
            //URLQueryItem(name: "status", value: "available")
        ]
        //https://petstore.swagger.io/v2/pet/findByStatus?status=available
        //http://localhost:3000/following_list
        
        let processInfo = ProcessInfo.processInfo
        if let apiKey = processInfo.environment["YOUTUBE_API_KEY"] {
            // Use the API key
            Logger().info("API KEY: \(apiKey)")
        } else {
            // API key not found
            Logger().info("API key not set")
        }
        
        return components
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, PlaylistError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    Logger().info("The data: \(data.toString()!)")
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

enum PlaylistError: Error {
    case parsing(description: String)
    case network(description: String)
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
