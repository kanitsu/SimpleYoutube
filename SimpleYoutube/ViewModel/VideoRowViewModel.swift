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
        return code
    }
    
    var code: String {
        return item.code
    }
}

extension VideoRowViewModel: Hashable {
  static func == (lhs: VideoRowViewModel, rhs: VideoRowViewModel) -> Bool {
    return lhs.code == rhs.code
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.code)
  }
}
