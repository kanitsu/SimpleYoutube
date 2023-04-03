//
//  CommentsViewModel.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import Foundation
import Combine


class CommentsViewModel: ObservableObject {
    @Published var dataSource: [CommentRowViewModel] = []
    @Published var loading: Bool = false;
    @Published var hasMore: Bool = true;
    
    private var videoId: String
    private let commentsFetcher: CommentsFetchable
    private var disposables = Set<AnyCancellable>()
    private var nextToken: String = ""
    
    init(
        videoId: String,
        scheduler: DispatchQueue = DispatchQueue(label: "CommentsViewModel")
    ) {
        self.videoId = videoId
        self.commentsFetcher = CommentsFetcher()
    }
    
    func addMoreContent() {
        if !loading {
            do {
                loading = true
                try fetchComment(forVideoId: videoId)
            }
            catch {
                fatalError("\(error.localizedDescription)")
            }
        }
    }
    
    func fetchComment(forVideoId id: String) throws {
        var publisher : AnyPublisher<Comments, APIError>
        do {
            try publisher = commentsFetcher.getComments(forVideoId: id, withToken: nextToken)
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
                    let newComments = response.items.map({
                        CommentRowViewModel.init(comment: $0.snippet.topLevelComment, replyComments: $0.replies?.comments)
                    })
                    self.dataSource.append(contentsOf: newComments)
                    guard let nextPageToken = response.nextPageToken else {
                        self.nextToken = ""
                        self.hasMore = false
                        return
                    }
                    self.nextToken = nextPageToken
                }
            ).store(in: &disposables)
    }
    
}
