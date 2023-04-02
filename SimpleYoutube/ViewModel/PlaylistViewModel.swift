//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Combine
import Foundation

class PlaylistViewModel: ObservableObject {
    @Published var id: String = "PLS3XGZxi7cBWCGHov7-D4fhUk1yhUK0o1"
    @Published var dataSource: [VideoRowViewModel] = []
    
    private let playlistFetcher: PlaylistFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(
        playlistFetcher: PlaylistFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "PlaylistViewModel")
    ) {
        self.playlistFetcher = playlistFetcher
        
        do {
            try fetchPlaylist(forId: id)
        }
        catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func fetchPlaylist(forId id: String) throws {
        var publisher : AnyPublisher<Playlist, PlaylistError>
        do {
            try publisher = playlistFetcher.getPlaylist(forId: id)
        }
        catch {
            throw error
        }
        
        publisher
            .map { response in
                response.items.map(VideoRowViewModel.init)
            }
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
                    self.dataSource = playlist
                }
            )
            .store(in: &disposables)
    }
}

protocol PlaylistFetchable {
    func getPlaylist(
        forId id: String
    ) throws -> AnyPublisher<Playlist, PlaylistError>
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
    ) throws -> AnyPublisher<Playlist, PlaylistError> {
        var urlComp: URLComponents
        do {
            try urlComp = getPlaylistItem(withId: id)
        } catch {
            throw error
        }
        
//        if let url = urlComp.url {
//            let urlString = url.absoluteString
//            print("Full URL: \(urlString)")
//        }
        
        return fetch(with: urlComp)
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
    ) throws -> URLComponents {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["YOUTUBE_API_KEY"] as? String else {
            throw PlaylistError.setting(description: "Unable to read Info.plist or YOUTUBE_API_KEY not defined in it.")
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "youtube.googleapis.com"
        components.path = "/youtube/v3/playlistItems"
        components.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "maxResults", value: "30"),
            URLQueryItem(name: "playlistId", value: id),
            URLQueryItem(name: "key", value: apiKey)
            
        ]
        //https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet%2Cstatus&maxResults=25&playlistId=PLF4D8851BA7D9DA6E&key=
        
        return components
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, PlaylistError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    //print("The data: \(data.toString()!)")
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

enum PlaylistError: Error {
    case setting(description: String)
    case parsing(description: String)
    case network(description: String)
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
