//
//  CommentsView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/3/23.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var viewModel: CommentsViewModel
    
    init(viewModel: CommentsViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            Text("Comments")
        }
    }
}
