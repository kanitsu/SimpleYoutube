//
//  YoutubeVideoView.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import WebKit
import SwiftUI

struct YoutubeVideoView: UIViewRepresentable {
    let videoId: String
        
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(videoId)")!))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(videoId)")!))
    }
}
