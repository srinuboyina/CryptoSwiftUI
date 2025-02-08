//
//  LineGraph.swift
//  CryptoSwiftUI
//
//  Created by apple on 08/02/25.
//

import UIKit
import DGCharts
import SwiftUI

class CustomLineChartView: UIView {
    
    private let chartView = LineChartView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChart()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChart()
    }

    private func setupChart() {
        addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: topAnchor),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        chartView.backgroundColor = .systemBackground
        chartView.rightAxis.enabled = false  // Hide right axis
        chartView.chartDescription.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        
        let yAxis = chartView.leftAxis
        yAxis.labelTextColor = .gray
        yAxis.axisLineColor = .gray
        yAxis.labelFont = UIFont.systemFont(ofSize: 12)

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .gray
        xAxis.axisLineColor = .gray
        xAxis.labelFont = UIFont.systemFont(ofSize: 12)
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        chartView.legend.textColor = .gray
        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
    }

    func setData(values: [(x: Double, y: Double)]) {
        let entries = values.map { ChartDataEntry(x: $0.x, y: $0.y) }
        let dataSet = LineChartDataSet(entries: entries, label: "Performance")
        
        dataSet.colors = [.systemBlue]
        dataSet.valueColors = [.clear]
        dataSet.valueFont = UIFont.boldSystemFont(ofSize: 0)
        dataSet.lineWidth = 2.5
        dataSet.drawCirclesEnabled = true
        dataSet.circleColors = [.red]
        dataSet.circleHoleColor = .white
        dataSet.circleRadius = 5.0
        dataSet.mode = .cubicBezier  // Smooth curved line
        chartView.data = LineChartData(dataSet: dataSet)
    }
}

struct LineChartWrapper: UIViewRepresentable {
    var entries: [(x: Double, y: Double)]

    func makeUIView(context: Context) -> CustomLineChartView {
        let chartView = CustomLineChartView()
        return chartView
    }

    func updateUIView(_ uiView: CustomLineChartView, context: Context) {
        uiView.setData(values: entries)
    }
}
