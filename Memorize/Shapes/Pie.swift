//
//  Pie.swift
//  Memorize
//
//  Created by Evgeniy Kurapov on 07.06.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var isClockwise: Bool = true
    
    var animatableData: AnimatablePair<Double, Double> {
        get { return AnimatablePair(startAngle.radians, endAngle.radians) }
        set {
            startAngle.radians = newValue.first
            endAngle.radians = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.height, rect.width) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let start = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                            y: center.y + radius * sin(CGFloat(startAngle.radians)))
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: isClockwise)
        path.addLine(to: center)
        return path
    }
}
