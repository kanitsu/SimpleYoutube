//
//  VideoViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine

class VideoViewModel: ObservableObject {
    @Published var photoUrl: String?
    
    private let data: VideoData
    private let channelFetcher: ChannelFetchable
    private var disposables = Set<AnyCancellable>()
    
    static var urlDictionary = [String: String]()
    
    init(
        data: VideoData,
        scheduler: DispatchQueue = DispatchQueue(label: "VideoViewModel")
    ) {
        self.data = data
        self.channelFetcher = ChannelFetcher()
        
        if VideoViewModel.urlDictionary.keys.contains(self.ownerId) {
            self.photoUrl = VideoViewModel.urlDictionary[self.ownerId]
        }
        else {
            do {
                try fetchPhotoUrl(forId: self.ownerId)
            }
            catch {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
    
    var videoId: String {
        return data.videoId
    }
    
    var title: String {
        return data.title
    }
    
    var owner: String {
        return data.owner
    }
    
    var ownerId: String {
        return data.ownerId
    }
    
    var publishedAt: String {
        return data.publishedAt
    }
    
    var description: String {
        return data.description
    }
    
    func fetchPhotoUrl(forId id: String) throws {
        var publisher : AnyPublisher<Channel, APIError>
        do {
            try publisher = channelFetcher.getPlaylist(forId: id)
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
                            self.photoUrl = nil
                        case .finished:
                            break
                    }
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.photoUrl = response.items[0].snippet.thumbnails.medium?.url ?? response.items[0].snippet.thumbnails.default?.url
                    if self.photoUrl != nil {
                        VideoViewModel.urlDictionary[self.ownerId] = self.photoUrl
                    }
                }
            )
            .store(in: &disposables)
    }
    
    struct VideoData {
        let videoId: String
        let title: String
        let owner: String
        let publishedAt: String
        let description: String
        let ownerId: String
    }
}
