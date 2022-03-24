//
//  ContentView.swift
//  Shared
//
//  Created by Hau Huynh on 14/12/2021.
//

import SwiftUI

struct ContentView: View {
    private let tabItems: [Tab]
    @State var selectedTab: Int
    init() {
        tabItems = [
            Tab(title: "Trend", icon: "chart.bar", id: 0),
            Tab(title: "Billboard", icon: "circle", id: 1),
            Tab(title: "Wall", icon: "newspaper", id: 2)
        ]
        selectedTab = tabItems[1].id
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedTab {
                    case tabItems[0].id:
                        TrendView()
                    case tabItems[1].id:
                        BillboardView()
                    default:
                        WallView()
                    }
                }
                
                HStack {
                    ForEach(tabItems) { item in
                        Button {
                            selectedTab = item.id
                        } label: {
                            item
                        }
                        .padding()
                        .foregroundColor(selectedTab == item.id ? .primary : .secondary)
    //                    .background(.ultraThinMaterial)
    //                    .background(selectedTab == item.id ? .purple : .white.opacity(0))
                        .clipShape(Circle())
                    }
                }
                .padding(.bottom, 16)
                .background(.ultraThinMaterial)
                .cornerRadius(64)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarHidden(true)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BillboardView()
//    }
//}
