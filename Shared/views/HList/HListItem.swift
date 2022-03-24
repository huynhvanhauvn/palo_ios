//
//  HListItem.swift
//  Palo
//
//  Created by Hau Huynh on 24/12/2021.
//

import SwiftUI

struct HListItem: View {
    let movie: Movie
    var body: some View {
        AsyncImage(url: URL(string: movie.poster ?? "")!,
                   placeholder: {Color.black},
                   image: { image in
            Image(uiImage: image).resizable()
            
        })
            .scaledToFill()
            .frame(width: 120, height: 150)
            .cornerRadius(16)
            .clipped()
    }
}

//

