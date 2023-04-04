//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Foundation
import Combine

class PlaylistViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var hasMore: Bool = true
    @Published var searchKeyword: String = ""
    
    @Published var dataSource: [VideoRowViewModel] = []
    private var origin: [VideoRowViewModel] = []
    
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
        guard let infoDict = Bundle.main.infoDictionary, let id = infoDict["YOUTUBE_PLAYLIST_ID"] as? String else {
            fatalError("Unable to read Info.plist or YOUTUBE_PLAYLIST_ID not defined in it.")
        }
        
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
    
    func search(keyword: String) {
        searchKeyword = keyword
        let tokens = keyword.components(separatedBy: " ")
        if origin.count < 1 {
            origin = dataSource
        }
        dataSource = origin.filter { item in
            tokens.contains { keyword in
                item.title.range(of: keyword, options: .caseInsensitive) != nil
            }
        }
    }
    
    func clearSearch() {
        searchKeyword = ""
        dataSource = origin
        origin = []
    }
    
    func fetchPlaylist(forId id: String) throws {
        var publisher : AnyPublisher<Playlist, APIError>
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
                            break
                        case .finished:
                            self.loading = false
                            break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    let playlist = response.items.filter { $0.snippet.videoOwnerChannelTitle != nil }
                        .map(VideoRowViewModel.init)
                    
                    if self.origin.count > 0 {
                        let tokens = self.searchKeyword.components(separatedBy: " ")
                        let filteredPlaylist = playlist.filter { item in
                            tokens.contains { keyword in
                                item.title.range(of: keyword, options: .caseInsensitive) != nil
                            }
                        }
                        self.dataSource.append(contentsOf: filteredPlaylist)
                        self.origin.append(contentsOf: playlist)
                    } else {
                        self.dataSource.append(contentsOf: playlist)
                    }
                    
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

extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
    }
}
