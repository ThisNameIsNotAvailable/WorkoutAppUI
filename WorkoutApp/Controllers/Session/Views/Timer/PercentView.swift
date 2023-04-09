//
//  PercentView.swift
//  WorkoutApp
//
//  Created by Alex on 08/04/2023.
//

import UIKit

extension TimerView {
    final class PercentView: BaseView {
        private let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fillProportionally
            stack.spacing = 5
            return stack
        }()
        
        private let percentValueLabel: UILabel = {
            let label = UILabel()
            label.font = Resources.Fonts.helveticaRegular(with: 23)
            label.textColor = Resources.Colors.darkGrey
            label.textAlignment = .center
            return label
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = Resources.Fonts.helveticaRegular(with: 10)
            label.textColor = Resources.Colors.inactive
            label.textAlignment = .center
            return label
        }()
    }
}

extension TimerView.PercentView {
    override func addViews() {
        super.addViews()
        [
            percentValueLabel,
            titleLabel
        ].forEach { el in
            stackView.addArrangedSubview(el)
        }
        
        addView(stackView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
    }
    
    func configure(with value: Int, title: String) {
        percentValueLabel.text = "\(value)%"
        titleLabel.text = title
    }
}
