//
//  ChartView.swift
//  Palo
//
//  Created by Hau Huynh on 24/12/2021.
//

import SwiftUI

struct ChartView: View {
    let movies: [Movie]
    let dateViewsList: [[DateView]]
//    @ObservedObject var chartViewmodel = ChartViewViewModel()
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var showMovieIndex: Int = 0
    private let dispatchQueue = DispatchQueue(label: "trendQueue", qos: .background)
    
    func maxView(data: [[DateView]]) -> Int {
        var allviews: [Int] = []
        for(_, e) in data.enumerated() {
            let values: [Int] = e.map {
                return Int($0.view) ?? 0
            }
            allviews += values
        }
        return allviews.max() ?? 1
    }
    
    var body: some View {
        VStack {
            let screenWidth: CGFloat = UIScreen.main.bounds.width
            let height: CGFloat = 200
            let colors: [Color] = [.orange, .green, .cyan]
            let gradientStart: [UnitPoint] = [.bottomLeading, .topTrailing, .bottom]
            let gradientEnd: [UnitPoint] = [.topTrailing, .bottomLeading, .top]
            ZStack {
//                let dateViewsList = chartViewmodel.dateViews
                let _ = print(">>>>>>>>>>>>>>>>>>>")
                let _ = print(dateViewsList)
                if dateViewsList.count > 0 {
                    let _ = print("\\\\\\\\\\\\\\\\\\\\\\\\")
                    let _ = print(dateViewsList)
                    ForEach(0..<dateViewsList.count) { i in
                        let dateViews = dateViewsList[i]
                        let maxValue = maxView(data: dateViewsList)
                        if dateViews.count > 0 {
                            let values: [Int] = dateViews.map {
                                return Int($0.view) ?? 0
                            }
                            LineShape(values: values, maxValue: maxValue)
                                .stroke(colors[i], lineWidth: showMovieIndex == i ? 5.0 : 2.0)
                                .frame(width: screenWidth - 16 * 2, height: height - 16 * 2, alignment: .center)
                        }
                    }
                }
            }
            .frame(width: screenWidth - 16 * 2, height: height)
            .background(LinearGradient(colors: [colors[showMovieIndex], .clear], startPoint: gradientStart[showMovieIndex], endPoint: gradientEnd[showMovieIndex]))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
//            .animation(.easeInOut(duration: 1000), value: showMovieIndex)
//            .onAppear {
//                chartViewmodel.fetchDateViewList(movies: self.movies)
//            }
            HStack {
                ForEach(0..<movies.count) { i in
                    let itemWidth: CGFloat = (screenWidth - 16 * 3)/3
                    let itemHeight: CGFloat = 150
                    NavigationLink(destination: MovieView(idMovie: movies[i].id!)) {
                        ZStack(alignment: .topLeading) {
                            AsyncImage(url: URL(string: movies[i].poster ?? "")!,
                                       placeholder: {Color.black},
                                       image: { image in
                                Image(uiImage: image).resizable()
                                
                            })
                                .scaledToFill()
                                .frame(width: itemWidth, height: itemHeight)
                            Circle()
                                .fill(colors[i])
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding(.top, -28)
                                .padding(.leading, -48)
                            Text(String(i+1))
                                .font(Font.system(size: 50, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .padding(.leading, 8)
                        }
                        .frame(width: itemWidth, height: itemHeight)
                        .cornerRadius(16)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(showMovieIndex == i ? colors[i] : .clear, lineWidth: 4)
                    )
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            if (showMovieIndex >= 0 && showMovieIndex < movies.count-1) {
                showMovieIndex += 1
            } else {
                showMovieIndex = 0
            }
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
