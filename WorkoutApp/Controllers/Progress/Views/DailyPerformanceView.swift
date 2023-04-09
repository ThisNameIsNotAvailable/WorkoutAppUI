//
//  DailyPerformanceView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class DailyPerformanceView: BaseInfoView {
    private let barsView = BarsView()
    
    override func addViews() {
        super.addViews()
        
        addView(barsView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            barsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            barsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            barsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            barsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with items: [BarView.BarData]) {
        barsView.configure(with: items)
    }
    
    override func configure() {
        super.configure()
    }
}
