//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Combine
import Foundation

class PlaylistViewModel: ObservableObject {
    //@Published var id: String = "PLS3XGZxi7cBWCGHov7-D4fhUk1yhUK0o1"
    @Published var id: String = "PLJxnQXiytA_TNtGCQKyjz_KKMiGKjXRAL"
    @Published var dataSource: [VideoRowViewModel] = []
    @Published var loading: Bool = false;
    @Published var hasMore: Bool = true;
    
    private let playlistFetcher: PlaylistFetchable
    private var disposables = Set<AnyCancellable>()
    private var contentPerPage: Int = 30
    private var nextToken: String = ""
    
    init(
        playlistFetcher: PlaylistFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "PlaylistViewModel")
    ) {
        self.playlistFetcher = playlistFetcher
    }
    
    func addMoreContent() {
        if !loading {
            do {
                loading = true
                try fetchPlaylist(forId: id)
            }
            catch {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
    
    func fetchPlaylist(forId id: String) throws {
        var publisher : AnyPublisher<Playlist, PlaylistError>
        do {
            try publisher = playlistFetcher.getPlaylist(forId: id, withLimit: contentPerPage, andToken: nextToken)
        }
        catch {
            throw error
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure:
                            self.dataSource = []
                        case .finished:
                            self.loading = false
                            break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    let playlist = response.items.filter { $0.snippet.videoOwnerChannelTitle != nil }
                        .map(VideoRowViewModel.init)
                    self.dataSource.append(contentsOf: playlist)
                    self.contentPerPage = 20
                    guard let nextPageToken = response.nextPageToken else {
                        self.nextToken = ""
                        self.hasMore = false
                        return
                    }
                    self.nextToken = nextPageToken
                }
            )
            .store(in: &disposables)
    }
}

protocol PlaylistFetchable {
    func getPlaylist(
        forId id: String,
        withLimit limit: Int,
        andToken token: String
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
        forId id: String,
        withLimit limit: Int,
        andToken token: String
    ) throws -> AnyPublisher<Playlist, PlaylistError> {
        var urlComp: URLComponents
        do {
            try urlComp = getPlaylistItem(withId: id, withLimit: limit, andToken: token)
        } catch {
            throw error
        }
        
        if let url = urlComp.url {
            let urlString = url.absoluteString
            print("Full URL: \(urlString)")
        }
        
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
        withId id: String,
        withLimit limit: Int,
        andToken token: String
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
            URLQueryItem(name: "maxResults", value: String(limit)),
            URLQueryItem(name: "playlistId", value: id),
            URLQueryItem(name: "pageToken", value: token),
            URLQueryItem(name: "key", value: apiKey)
            
        ]
        //https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet%2Cstatus&maxResults=25&playlistId=PLF4D8851BA7D9DA6E&key=
        
        return components
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, PlaylistError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    print("The data: \(data.toString()!)")
    
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
