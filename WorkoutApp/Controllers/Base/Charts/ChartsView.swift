//
//  ChartsView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

extension ChartsView {
    struct ChartsData {
        let title: String
        let value: Int
    }
}

final class ChartsView: BaseView {
    
    private let yAxisView = ChartsYAxisView()
    private let xAxisView = ChartsXAxisView()
    
    private let chartView = ChartView()
    
    override func addViews() {
        super.addViews()
        
        addView(yAxisView)
        addView(xAxisView)
        addView(chartView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            yAxisView.leadingAnchor.constraint(equalTo: leadingAnchor),
            yAxisView.topAnchor.constraint(equalTo: topAnchor),
            yAxisView.bottomAnchor.constraint(equalTo: xAxisView.topAnchor, constant: -12),
            
            xAxisView.leadingAnchor.constraint(equalTo: yAxisView.trailingAnchor, constant: 8),
            xAxisView.bottomAnchor.constraint(equalTo: bottomAnchor),
            xAxisView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            chartView.bottomAnchor.constraint(equalTo: xAxisView.topAnchor, constant: -16),
            chartView.leadingAnchor.constraint(equalTo: yAxisView.trailingAnchor, constant: 16)
        ])
    }
    
    func configure(with data: [ChartsData], topChartOffset: Int) {
        yAxisView.configure(with: data)
        xAxisView.configure(with: data)
        chartView.configure(with: data, topChartOffset: topChartOffset)
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .clear
        
    }
}
