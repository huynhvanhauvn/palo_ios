//
//  TrendView.swift
//  Palo
//
//  Created by Hau Huynh on 24/12/2021.
//

import SwiftUI

struct TrendView: View {
    @ObservedObject var viewmodel = TrendViewModel()
    @ObservedObject var chartVM = ChartViewViewModel()
    private let dispatchQueue = DispatchQueue(label: "trendQueue", qos: .background)
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if viewmodel.trendMovies.count > 0 {
                        ChartView(movies: Array(viewmodel.trendMovies[..<3]), dateViewsList: viewmodel.dateViews)
                    }
                    if viewmodel.trendMovies.count > 3 {
                        VList(title: "", isMore: false, showNo: true, offsetNo: 3, movies: Array(viewmodel.trendMovies[3...]))
                    }
                    if viewmodel.trendArtists.count > 0 {
                        ArtistList(artists: viewmodel.trendArtists, showNo: true)
                    }
                    Spacer(minLength: 84)
                }
            }
            .onAppear {
                self.viewmodel.fetchTrendMovieList()
                self.viewmodel.fetchTrendArtistList()
            }
            .refreshable {
                print("refreshing...")
//                dispatchQueue.async(qos: .background) {
//                    self.viewmodel.fetchTrendMovieList()
//                    self.viewmodel.fetchTrendArtistList()
//                }
            }
            .background(
                LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        }
    }
    
    func showArtist(artist: Artist) {
        print(artist)
    }
}

//struct TrendView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendView()
//    }
//}
