//
//  CommentsViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine


class CommentsViewModel: ObservableObject {
    private var videoId: String
    
    init(videoId: String) {
        self.videoId = videoId
    }
    
}
