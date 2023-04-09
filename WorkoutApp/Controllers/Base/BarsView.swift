//
//  BarsView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class BarsView: BaseView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func addViews() {
        super.addViews()
        
        addView(stackView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(with data: [BarView.BarData]) {
        data.forEach { el in
            let barView = BarView(data: el)
            
            stackView.addArrangedSubview(barView)
        }
    }
}
