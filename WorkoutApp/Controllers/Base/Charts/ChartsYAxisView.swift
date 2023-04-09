//
//  ChartsYAxisView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class ChartsYAxisView: BaseView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
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
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with data: [ChartsView.ChartsData]) {
        
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        (0...9).reversed().forEach { i in
            let label = UILabel()
            label.font = Resources.Fonts.helveticaRegular(with: 9)
            label.textColor = Resources.Colors.inactive
            label.textAlignment = .right
            label.text = "\(i * 10)"
            
            stackView.addArrangedSubview(label)
        }
    }
}
