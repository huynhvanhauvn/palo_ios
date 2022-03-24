//
//  SwiftUIView.swift
//  Palo (iOS)
//
//  Created by Hau Huynh on 21/01/2022.
//

import SwiftUI

struct ArtistMovieView: View {
    let title: String
    let artists: [Artist]
    var body: some View {
        if artists.count > 0 {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.title3)
                VStack {
                    Divider()
                        .background(.white)
                }
            }
            .padding(.horizontal)
            ArtistList(artists: artists)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
