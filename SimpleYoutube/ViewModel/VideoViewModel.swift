//
//  VideoViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation

class VideoViewModel: ObservableObject {
    private let data: VideoData
    
    struct VideoData {
        let videoId: String
        let title: String
        let owner: String
        let publishedAt: String
        let description: String
    }
    
    init(data: VideoData) {
        self.data = data
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
    
    var publishedAt: String {
        return data.publishedAt
    }
    
    var description: String {
        return data.description
    }
}
