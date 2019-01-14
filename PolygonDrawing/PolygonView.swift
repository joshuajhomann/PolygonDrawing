//
//  PolygonView.swift
//  PolygonDrawing
//
//  Created by Joshua Homann on 1/13/19.
//  Copyright © 2019 com.josh. All rights reserved.
//

import UIKit

@IBDesignable class PolygonView: UIView {
    @IBInspectable var gridSpacing: CGFloat = 24 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var gridColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var polygonColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).withAlphaComponent(0.75) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var polygonVertextColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var polygonFirstVertextColor: UIColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var polygonStrokeWidth: CGFloat = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var polygonVertexRadius: CGFloat = 12 {
        didSet {
            setNeedsDisplay()
        }
    }
    var polygon: Polygon? {
        didSet {
            setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setLineWidth(1 / UIScreen.main.nativeScale)
        gridColor.setStroke()
        stride(from: 0, to: bounds.width, by: gridSpacing).forEach { x in
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: bounds.size.height))
        }
        stride(from: 0, to: bounds.height, by: gridSpacing).forEach { y in
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: bounds.size.width, y: y))
        }
        context.strokePath()

        guard let polygon = polygon,
              let origin = polygon.vertices.first else {
            return
        }
        context.setLineWidth(polygonStrokeWidth)
        polygonColor.setStroke()
        polygonColor.setFill()
        context.move(to: origin)
        polygon.vertices.dropFirst().forEach { context.addLine(to: $0) }
        if polygon.isClosed {
            context.closePath()
            context.fillPath()
        }
        context.strokePath()

        polygonVertextColor.setFill()
        polygon.vertices.dropFirst().forEach { point in
            context.fillEllipse(in: CGRect(
                x: point.x - polygonVertexRadius,
                y: point.y - polygonVertexRadius,
                width: polygonVertexRadius * 2,
                height: polygonVertexRadius * 2)
            )
        }
        polygonFirstVertextColor.setFill()
        context.fillEllipse(in: CGRect(
            x: origin.x - polygonVertexRadius,
            y: origin.y - polygonVertexRadius,
            width: polygonVertexRadius * 2,
            height: polygonVertexRadius * 2)
        )
    }
}
