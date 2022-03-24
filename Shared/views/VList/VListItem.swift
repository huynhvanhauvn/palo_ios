//
//  VListItem.swift
//  Palo
//
//  Created by Hau Huynh on 23/12/2021.
//

import SwiftUI

struct VListItem: View {
    let movie: Movie
    let index: Int?
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: movie.poster ?? "")!,
                               placeholder: {Color.black},
                               image: { image in
                        Image(uiImage: image).resizable()
                        
                    })
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(16)
                        .clipped()
                    if index != nil {
                        Text(String(index!))
                            .font(Font.system(size: 60, weight: .heavy, design: .default))
                            .padding(.vertical, -18)
                            .foregroundColor(.white.opacity(0.64))
                    }
                }
                VStack(alignment: .leading) {
                    Text(movie.title ?? "")
                        .bold()
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(movie.director != nil && movie.director != "" ? movie.director! : "Updating...")
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }
            .background(.ultraThinMaterial)
            .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
}

//struct VListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        VListItem()
//    }
//}
