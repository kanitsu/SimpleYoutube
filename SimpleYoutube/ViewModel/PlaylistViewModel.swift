//
//  PlaylistViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import Foundation
import Combine

class PlaylistViewModel: ObservableObject {
    @Published var id: String = "PLS3XGZxi7cBWCGHov7-D4fhUk1yhUK0o1"
    //@Published var id: String = "PLJxnQXiytA_TNtGCQKyjz_KKMiGKjXRAL"
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
