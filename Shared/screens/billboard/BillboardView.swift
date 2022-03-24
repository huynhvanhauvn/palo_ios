//
//  BillboardView.swift
//  Palo
//
//  Created by Hau Huynh on 17/12/2021.
//

import SwiftUI

struct BillboardView: View {
    @ObservedObject var viewmodel = BillboardViewModel()
    let dispatchQueue = DispatchQueue(label: "billboardQueue", qos: .background)
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if viewmodel.promotions.count > 0 { PromotionView(promotions: viewmodel.promotions, width: proxy.size.width, height: 200)
                    }
                    if viewmodel.recentMovies.count > 0 {
                        HList(title: "Recent Movies", isMore: true, movies: viewmodel.recentMovies)
                    }
                    if viewmodel.bestMovies.count > 0 {
                        VList(title: "Best Movies", isMore: true, showNo: false, offsetNo: 0, movies: viewmodel.bestMovies)
                    }
                    Spacer(minLength: 90)
                }
            }
            .onAppear {
                self.viewmodel.fetchPromotionList()
                self.viewmodel.fetchRecentMovieList()
                self.viewmodel.fetchBestMovieList()
            }
            .background(
                LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    //                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct BillboardView_Previews: PreviewProvider {
    static var previews: some View {
        BillboardView()
    }
}
