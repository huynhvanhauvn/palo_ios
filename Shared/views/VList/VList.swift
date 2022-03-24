//
//  VList.swift
//  Palo
//
//  Created by Hau Huynh on 23/12/2021.
//

import SwiftUI

struct VList: View {
    let title: String
    let isMore: Bool
    let showNo: Bool
    let offsetNo: Int
    let movies: [Movie]
    var body: some View {
        VStack {
            if title != "" {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    if isMore {
                        Spacer()
                        Text("View more")
                            .foregroundColor(.white)
                        .padding()}
                }
            }
            ForEach(0..<movies.count) { index in
                NavigationLink(destination: MovieView(idMovie: self.movies[index].id!)) {
                    VListItem(movie: movies[index], index: showNo ? index+1+offsetNo : nil)
                }
            }
        }
    }
}

//struct VList_Previews: PreviewProvider {
//    static var previews: some View {
//        VList()
//    }
//}
