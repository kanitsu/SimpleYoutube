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
}

extension VideoRowViewModel: Hashable {
  static func == (lhs: VideoRowViewModel, rhs: VideoRowViewModel) -> Bool {
    return lhs.videoId == rhs.videoId
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.videoId)
  }
}
