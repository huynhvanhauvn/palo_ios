//
//  HList.swift
//  Palo
//
//  Created by Hau Huynh on 23/12/2021.
//

import SwiftUI

struct HList: View {
    let title: String
    let isMore: Bool
    let movies: [Movie]
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                if isMore{Spacer()
                    Text("View more")
                        .foregroundColor(.white)
                    .padding()}
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieView(idMovie: movie.id!)) {
                            HListItem(movie: movie)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

//struct HList_Previews: PreviewProvider {
//    static var previews: some View {
//        HList()
//    }
//}
