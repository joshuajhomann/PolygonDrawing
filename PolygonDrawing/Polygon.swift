//
//  Polygon.swift
//  PolygonDrawing
//
//  Created by Joshua Homann on 1/13/19.
//  Copyright © 2019 com.josh. All rights reserved.
//

import UIKit

struct Polygon {
    var vertices: [CGPoint] = []
    var isClosed: Bool = false
    var cgPath: CGPath {
        let path = CGMutablePath()
        guard let origin = vertices.first else {
            return path
        }
        path.move(to: origin)
        vertices.dropFirst().forEach { path.addLine(to: $0) }
        if isClosed {
            path.closeSubpath()
        }
        return path
    }
}
