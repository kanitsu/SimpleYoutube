//
//  VideoRowViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/2/23.
//

import Foundation

struct VideoRowViewModel: Identifiable {
    private let item: Playlist.Item
    
    init(item: Playlist.Item) {
      self.item = item
    }
    
    var id: String {
        return videoId
    }
    
    var videoId: String {
        return item.snippet.resourceId.videoId
    }
    
    var title: String {
        return item.snippet.title
    }
    
    var owner: String {
        return item.snippet.videoOwnerChannelTitle ?? "Unknown"
    }
    
    var publishedAt: String {
        let isoDateFormatter = ISO8601DateFormatter()
        guard let date = isoDateFormatter.date(from: item.snippet.publishedAt) else {
            return item.snippet.publishedAt
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "GMT+8")
        return dateFormatter.string(from: date)
    }
    
    var thumbnails: Playlist.Thumbnails {
        return item.snippet.thumbnails
    }
    
    func createVideoViewModel() -> VideoViewModel {
        return VideoViewModel(data: VideoViewModel.VideoData(videoId: videoId,
                                                             title: title,
                                                             owner: owner,
                                                             publishedAt: publishedAt,
                                                             description: item.snippet.description
        ))
    }
}

extension VideoRowViewModel: Hashable {
  static func == (lhs: VideoRowViewModel, rhs: VideoRowViewModel) -> Bool {
    return lhs.videoId == rhs.videoId
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.videoId)
  }
}
