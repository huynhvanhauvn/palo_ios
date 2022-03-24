//
//  ArtistList.swift
//  Palo
//
//  Created by Hau Huynh on 25/12/2021.
//

import SwiftUI

struct ArtistList: View {
    let artists: [Artist]
    var showNo: Bool = false
    var body: some View {
        let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
        LazyVGrid(columns: gridItems) {
            ForEach(0..<artists.count) { i in
                NavigationLink(destination: ArtistView()) {
                    ArtistListItem(artist: artists[i], index: showNo ? i+1 : nil)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

//struct ArtistList_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistList()
//    }
//}
