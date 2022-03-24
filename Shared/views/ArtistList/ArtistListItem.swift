//
//  ArtistListItem.swift
//  Palo
//
//  Created by Hau Huynh on 25/12/2021.
//

import SwiftUI

struct ArtistListItem: View {
    let artist: Artist
    var index: Int?
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: 50)
                .foregroundColor(.white)
                .cornerRadius(25)
            HStack {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: artist.image)!,
                               placeholder: {Color.black},
                               image: { image in
                        Image(uiImage: image).resizable()
                        
                    })
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle()
                        .stroke(.white, lineWidth: 4))
                    if index != nil {
                        Text(String(index!))
                            .font(Font.system(size: 40, weight: .heavy, design: .default))
                            .padding(.vertical, -12)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                HStack {
                    Text(artist.name)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
    }
}

//struct ArtistListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtistListItem()
//    }
//}
