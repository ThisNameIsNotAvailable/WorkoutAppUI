//
//  MonthlyPerformanceView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class MonthlyPerformanceView: BaseInfoView {
    private let chartsView = ChartsView()
    
    override func addViews() {
        super.addViews()
        
        addView(chartsView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            chartsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            chartsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            chartsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            chartsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with items: [ChartsView.ChartsData], topChartOffset: Int = 10) {
        chartsView.configure(with: items, topChartOffset: topChartOffset)
    }
    
    override func configure() {
        super.configure()
    }
}

