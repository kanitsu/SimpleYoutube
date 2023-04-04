//
//  PlaylistView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 3/29/23.
//

import SwiftUI

struct PlaylistView: View {
    @ObservedObject var viewModel: PlaylistViewModel
    @State private var scrollProxy: ScrollViewProxy?
    @State private var isShowingSearch = false
    
    init(viewModel: PlaylistViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.dataSource, id: \.id, content: VideoRowView.init(viewModel:))
                        if viewModel.hasMore {
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                                .onAppear {
                                    viewModel.addMoreContent()
                                }
                        }
                    }
                    .id("theTop")
                }
                .sheet(isPresented: $isShowingSearch) {
                    SearchDialog(isShowing: $isShowingSearch, searchText: "") { keyword in
                        if keyword.count > 0 {
                            viewModel.search(keyword: keyword)
                        } else {
                            viewModel.clearSearch()
                        }
                        scrollProxy?.scrollTo("theTop", anchor: .top)
                    }
                }
                .onAppear {
                    self.scrollProxy = proxy
                }
                .navigationBarTitle(Text(viewModel.searchKeyword.count > 0 ? "🔍\(viewModel.searchKeyword)" : "Simple Youtube"), displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        viewModel.clearSearch()
                        scrollProxy?.scrollTo("theTop", anchor: .top)
                    }) {
                        if viewModel.searchKeyword.count > 0 {
                            Text("Cancel\nSearch")
                                .font(.footnote)
                        } else {
                            Text("")
                        }
                    },
                    trailing: Button(action: {
                        self.isShowingSearch = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                )
            }
        }
    }
}

struct SearchDialog: View {
    @Binding var isShowing: Bool
    @State var searchText: String = ""
    var onSearch: ((String) -> Void)?
    
    var body: some View {
        VStack {
            Text("Search")
                .font(.title)
                .padding(.top, 16)
            
            TextField("Enter search term", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                Button(action: search) {
                    Text("Search")
                }
                Spacer()
                Button(action: {
                    isShowing = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .padding(.top, 16)
            
        }
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding(.horizontal, 32)
    }
    
    private func search() {
        onSearch?(searchText)
        isShowing = false
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(viewModel: PlaylistViewModel(playlistFetcher: PlaylistFetcher()))
    }
}
