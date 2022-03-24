//
//  PromotionItemView.swift
//  Palo
//
//  Created by Hau Huynh on 18/12/2021.
//

import SwiftUI

struct PromotionItemView: View {
    let promotion: Promotion
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        ZStack() {
            AsyncImage(url: URL(string: promotion.image)!,
                       placeholder: {Color.black},
                       image: { image in
                Image(uiImage: image).resizable()
                
            })
                .aspectRatio(contentMode: .fill)
                .frame(width: width - 32, height: height, alignment: .center)
                .cornerRadius(16)
                .clipped()
                .padding(.horizontal, 16)
            Text("\(promotion.name)")
                .padding()
                .foregroundColor(.white)
                .background(.black.opacity(0.28))
                .cornerRadius(16)
        }
    }
}

//struct PromotionItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        PromotionItemView(promotion: p)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
