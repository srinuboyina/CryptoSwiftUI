//
//  CryptoGraphView.swift
//  CryptoSwiftUI
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct LineGraph: Shape {
    var data: [Double]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard data.count > 1 else { return path }

        let stepX = rect.width / CGFloat(data.count - 1)
        let minValue = data.min() ?? 0
        let maxValue = data.max() ?? 1
        let range = maxValue - minValue

        func yPosition(_ value: Double) -> CGFloat {
            let normalized = (value - minValue) / range
            return rect.height * (1 - normalized)
        }

        path.move(to: CGPoint(x: 0, y: yPosition(data[0])))
        for index in 1..<data.count {
            let x = CGFloat(index) * stepX
            let y = yPosition(data[index])
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return path
    }
}

struct CryptoGraphView: View {
    @State var cryptoData: [Double] = []
    @State private var hoverIndex: Int? = nil
    @State private var hoverPosition: CGPoint = .zero

    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ZStack {
                    // Line Graph
                    LineGraph(data: cryptoData)
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(height: 200)

                    // Hover Interaction Overlay
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .frame(height: 200)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let stepX = geometry.size.width / CGFloat(cryptoData.count - 1)
                                    let index = min(max(Int(value.location.x / stepX), 0), cryptoData.count - 1)
                                    hoverIndex = index
                                    hoverPosition = CGPoint(x: CGFloat(index) * stepX, y: value.location.y)
                                }
                                .onEnded { _ in
                                    hoverIndex = nil
                                }
                        )

                    // Hover Marker and Value
                    if let index = hoverIndex {
                        let stepX = geometry.size.width / CGFloat(cryptoData.count - 1)
                        let xPosition = CGFloat(index) * stepX
                        let yPosition = getYPosition(value: cryptoData[index], in: geometry)

                        VStack {
                            Text(String(format: "%.2f", cryptoData[index]))
                                .font(.caption)
                                .padding(5)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                               

                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                        }
                        .position(x: xPosition, y: yPosition)
                    }
                }
            }
            .frame(height: 250)
        }
        .padding()
    }

    // Function to get Y position based on value
    private func getYPosition(value: Double, in geometry: GeometryProxy) -> CGFloat {
        let minValue = cryptoData.min() ?? 0
        let maxValue = cryptoData.max() ?? 1
        let range = maxValue - minValue
        let normalized = (value - minValue) / range
        return geometry.size.height * (1 - normalized)
    }
}
