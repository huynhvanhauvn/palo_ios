//
//  Tab.swift
//  Palo
//
//  Created by Hau Huynh on 24/12/2021.
//

import SwiftUI

struct Tab: View, Identifiable {
    let title: String
    let icon: String
    let id: Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if icon != "" {
                    Image(systemName: icon)
                }
//                if title != "" {
//                    Text(title)
//                }
            }
            Spacer()
        }
    }
}

//struct Tab_Previews: PreviewProvider {
//    static var previews: some View {
//        Tab()
//    }
//}
