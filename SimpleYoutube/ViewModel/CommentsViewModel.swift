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
    
    private var videoId: String
    
    init(videoId: String) {
        self.videoId = videoId
        
        dataSource.append(
            CommentRowViewModel(
                comment: Comments.Comment(
                    id: "1",
                    snippet: Comments.CommentDetail(
                        textOriginal: "I'm on the same boat as you, and I downloaded the game cause I saw Nilihister leak too. Truthfully though, if they don't fix the rehab system and make it  so ppl can get copies easier I'm just gonna quit the game cause the future don't look good",
                        authorDisplayName: "AAAA",
                        authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                        updatedAt: "2023-03-28T14:54:12Z"
                    )
                )
            )
        )
        
        dataSource.append(
            CommentRowViewModel(
                comment: Comments.Comment(
                    id: "2",
                    snippet: Comments.CommentDetail(
                        textOriginal: "I'm on the same boat as you, and I downloaded the game cause I saw Nilihister leak too. Truthfully though, if they don't fix the rehab system and make it  so ppl can get copies easier I'm just gonna quit the game cause the future don't look good",
                        authorDisplayName: "BBBB",
                        authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                        updatedAt: "2023-03-28T14:54:12Z"
                    )
                ),
                replyComments: [
                    Comments.Comment(
                        id: "1",
                        snippet: Comments.CommentDetail(
                            textOriginal: "I'm on the same boat as you, and I downloaded the game cause I saw Nilihister leak too. Truthfully though, if they don't fix the rehab system and make it  so ppl can get copies easier I'm just gonna quit the game cause the future don't look good",
                            authorDisplayName: "AAAA",
                            authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                            updatedAt: "2023-03-28T14:54:12Z"
                        )
                    ), Comments.Comment(
                        id: "2",
                        snippet: Comments.CommentDetail(
                            textOriginal: "I'm on the same boat as you, and I downloaded the game cause I saw Nilihister leak too. Truthfully though, if they don't fix the rehab system and make it  so ppl can get copies easier I'm just gonna quit the game cause the future don't look good",
                            authorDisplayName: "BBBB",
                            authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                            updatedAt: "2023-03-28T14:54:12Z"
                        )
                    ), Comments.Comment(
                        id: "3",
                        snippet: Comments.CommentDetail(
                            textOriginal: "cccc cccc cccc cccc",
                            authorDisplayName: "CCCC",
                            authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                            updatedAt: "2023-03-28T14:54:12Z"
                        )
                    )
                ]
            )
        )
        
        dataSource.append(
            CommentRowViewModel(
                comment: Comments.Comment(
                    id: "3",
                    snippet: Comments.CommentDetail(
                        textOriginal: "cccc cccc cccc cccc",
                        authorDisplayName: "CCCC",
                        authorProfileImageUrl: "https://yt3.ggpht.com/ytc/AL5GRJXd2B6FrIzivUikyXEgxJ2M3GyGDFKidk5onr5SkEGzeQ3wzC902-BQvyttY8sm=s48-c-k-c0x00ffffff-no-rj",
                        updatedAt: "2023-03-28T14:54:12Z"
                    )
                )
            )
        )
    }
    
}
