//
//  LineGraph.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import UIKit

class SimpleLineGraphView: UIView {
    var dataPoints: [CGFloat] = [10, 20, 15, 30, 25, 40]

    override func draw(_ rect: CGRect) {
        guard dataPoints.count > 1 else { return }
        
        let path = UIBezierPath()
        let width = rect.width
        let height = rect.height
        let stepX = width / CGFloat(dataPoints.count - 1)
        
        let maxY = dataPoints.max() ?? 1
        let scaleFactor = maxY > 0 ? height / maxY : 1

        path.move(to: CGPoint(x: 0, y: height - dataPoints[0] * scaleFactor))
        for i in 1..<dataPoints.count {
            let x = CGFloat(i) * stepX
            let y = height - dataPoints[i] * scaleFactor
            path.addLine(to: CGPoint(x: x, y: y))
        }

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        layer.addSublayer(shapeLayer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.5
        shapeLayer.add(animation, forKey: "line")
    }
}

