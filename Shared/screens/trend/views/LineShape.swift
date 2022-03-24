//
//  LineShape.swift
//  Palo
//
//  Created by Hau Huynh on 25/12/2021.
//

import Foundation
import SwiftUI

struct LineShape: Shape {
    var values: [Int]
    var maxValue: Int

    func path(in rect: CGRect) -> Path {
        let yValues : [Double] = values.map { Double($0)/Double(maxValue) }
        let xIncrement = (rect.width / (CGFloat(yValues.count) - 1))
        var path = Path()
        path.move(to: CGPoint(x: 0.0,
                              y: -yValues[0] * Double(rect.height)+Double(rect.height)))
        for i in 1..<yValues.count {
            let pt = CGPoint(x: (Double(i) * Double(xIncrement)),
                             y: -(yValues[i] * Double(rect.height))+Double(rect.height))
            path.addLine(to: pt)
        }
        return path
    }
}
