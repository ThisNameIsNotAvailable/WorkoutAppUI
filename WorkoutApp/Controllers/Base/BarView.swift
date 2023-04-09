//
//  BarView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

extension BarView {
    struct BarData {
        let value: String
        let heightMultiplier: Double
        let title: String
    }
}

final class BarView: BaseView {
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 13)
        label.textColor = Resources.Colors.active
        return label
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.active
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 9)
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    private let heightMultiplier: Double
    
    init(data: BarData) {
        heightMultiplier = data.heightMultiplier
        super.init(frame: .zero)
        
        titleLabel.text = data.title
        valueLabel.text = data.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        super.addViews()
        
        addView(barView)
        addView(titleLabel)
        addView(valueLabel)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            barView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5),
            barView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barView.widthAnchor.constraint(equalToConstant: 17),
            barView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier, constant: -40*heightMultiplier),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: 10)
        ])
    }
}
