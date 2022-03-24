//
//  PromotionView.swift
//  Palo
//
//  Created by Hau Huynh on 18/12/2021.
//

import SwiftUI

struct PromotionView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    private let promotions: [Promotion]
    private let width: CGFloat
    private let height: CGFloat
    @State var showPromotion: Promotion
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    init(promotions: [Promotion], width: CGFloat, height: CGFloat) {
        self.promotions = promotions
        self.width = width
        self.height = height
        self.showPromotion = promotions[0]
    }
    
    var body: some View {
        TabView(selection: self.$showPromotion) {
            ForEach(promotions, id: \.self) { promotion in
                PromotionItemView(promotion: promotion, width: width, height: height).tag(promotion)
            }
        }
        .frame(width: width, height: height, alignment: .center)
        .animation(.easeInOut, value: showPromotion)
        .transition(.slide)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onReceive(timer) { _ in
            let index = promotions.firstIndex(of: showPromotion) ?? -1
            if (index>=0&&index<promotions.count-1) {
                showPromotion = promotions[index+1]
            } else {
                showPromotion = promotions[0]
            }
        }
    }
}

//struct PromotionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PromotionView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
