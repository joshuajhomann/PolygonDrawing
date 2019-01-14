//
//  ViewController.swift
//  PolygonDrawing
//
//  Created by Joshua Homann on 1/13/19.
//  Copyright © 2019 com.josh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var polygonView: PolygonView!
    private var polygon = Polygon()
    private var indexOfPointBeingDragged: Int?
    private let vertexRadius: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        polygonView.polygonVertexRadius = vertexRadius
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: polygonView)
        if let index = polygon.vertices.firstIndex(where: { $0.distance(to: tapPoint) <  vertexRadius }) {
            if index == 0 && polygon.isClosed {
                polygon.isClosed = false
            } else if index == 0 {
                polygon.isClosed = true
            } else {
                polygon.vertices.remove(at: index)
            }
        } else {
            polygon.vertices.append(tapPoint)
        }
        polygonView.polygon = polygon
    }
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        let tapPoint = sender.location(in: polygonView)
        switch sender.state {
        case .began:
            guard let index = polygon.vertices.firstIndex(where: { $0.distance(to: tapPoint) <  vertexRadius * 1.5 }) else {
                return
            }
            indexOfPointBeingDragged = index
        case .changed:
            guard let indexOfPointBeingDragged = indexOfPointBeingDragged else {
                return
            }
            polygon.vertices[indexOfPointBeingDragged] = tapPoint
            polygonView.polygon = polygon
        case .ended, .cancelled:
            guard let indexOfPointBeingDragged = indexOfPointBeingDragged else {
                return
            }
            polygon.vertices[indexOfPointBeingDragged] = tapPoint
            self.indexOfPointBeingDragged = nil
            polygonView.polygon = polygon
        default:
            break
        }
    }


}



