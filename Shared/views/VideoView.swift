//
//  VideoView.swift
//  Palo (iOS)
//
//  Created by Hau Huynh on 09/01/2022.
//

import SwiftUI
import WebKit
import AVKit

struct VideoView: UIViewRepresentable {
    let idVideo: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(idVideo)") else {return}
        var embedVideoHtml:String {
            return """
            <!DOCTYPE html>
            <html>
            <body>
            <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
            <div id="player"></div>

            <script>
            var tag = document.createElement('script');

            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

            var player;
            function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
            playerVars: { 'autoplay': 1, 'controls': 0, 'playsinline': 1 },
            height: '\(uiView.frame.height)',
            width: '\(uiView.frame.width)',
            videoId: '\(youtubeURL.lastPathComponent)',
            events: {
            'onReady': onPlayerReady
            }
            });
            }

            function onPlayerReady(event) {
            event.target.playVideo();
            }
            </script>
            </body>
            </html>
            """
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
//        uiView.loadHTMLString(embedVideoHtml, baseURL: nil)
    }
}

//struct VideoView: View {
//    let idVideo: String
//    @State var player = AVPlayer()
//
//    var body: some View {
//        VideoPlayer(player: player)
//            .onAppear() {
//                print(idVideo)
//                player = AVPlayer(url: URL(string: "https://www.youtube.com/embed/\(idVideo)")!)
//            }
//    }
//}

//class VideoView: View {
//
//    let idVideo: String = ""
//
//    @IBOutlet weak var videoPlayerView: WKWebView!
//    var videoURL:URL!  // has the form "https://www.youtube.com/embed/videoID"
//    var didLoadVideo = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        videoPlayerView.configuration.mediaTypesRequiringUserActionForPlayback = []
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Size of the webView is used to size the YT player frame in the JS code
//        // and the size of the webView is only known in `viewDidLayoutSubviews`,
//        // however, this function is called again once the HTML is loaded, so need
//        // to store a bool indicating whether the HTML has already been loaded once
//        if !didLoadVideo {
//            videoPlayerView.loadHTMLString(embedVideoHtml, baseURL: nil)
//            didLoadVideo = true
//        }
//    }
//
//    var embedVideoHtml:String {
//        return """
//        <!DOCTYPE html>
//        <html>
//        <body>
//        <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
//        <div id="player"></div>
//
//        <script>
//        var tag = document.createElement('script');
//
//        tag.src = "https://www.youtube.com/iframe_api";
//        var firstScriptTag = document.getElementsByTagName('script')[0];
//        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
//
//        var player;
//        function onYouTubeIframeAPIReady() {
//        player = new YT.Player('player', {
//        playerVars: { 'autoplay': 1, 'controls': 0, 'playsinline': 1 },
//        height: '\(videoPlayerView.frame.height)',
//        width: '\(videoPlayerView.frame.width)',
//        videoId: '\(URL("https://www.youtube.com/embed/\(idVideo)").lastPathComponent)',
//        events: {
//        'onReady': onPlayerReady
//        }
//        });
//        }
//
//        function onPlayerReady(event) {
//        event.target.playVideo();
//        }
//        </script>
//        </body>
//        </html>
//        """
//    }
//}
