//
//  StatsCellView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

enum StatsItem {
    case heartRate(value: String)
    case averagePace(value: String)
    case totalSteps(value: String)
    case totalDistance(value: String)
    
    var data: StatsCellView.CellItem {
        switch self {
        case .averagePace(let value):
            return .init(image: Resources.Images.Session.speedImage, value: "\(value) / km", title: "AVERAGE PACE")
        case .heartRate(let value):
            return .init(image: Resources.Images.Session.heartImage, value: "\(value) bpm", title: "HEART RATE")
        case .totalSteps(let value):
            return .init(image: Resources.Images.Session.stepsImage, value: "\(value)", title: "TOTAL STEPS")
        case .totalDistance(let value):
            return .init(image: Resources.Images.Session.mapsImage, value: "\(value) km", title: "TOTAL DISTANCE")
        }
    }
}

final class StatsCellView: BaseView {
    
    struct CellItem {
        let image: UIImage?
        let value: String
        let title: String
    }
    
    private let imageView = UIImageView()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 17)
        label.textColor = Resources.Colors.darkGrey
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 10)
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    override func addViews() {
        super.addViews()
        
        addView(imageView)
        [
            valueLabel,
            titleLabel
        ].forEach { el in
            stack.addArrangedSubview(el)
        }
        addView(stack)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 23),
            
            stack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
    }
    
    func configure(with item: StatsItem) {
        imageView.image = item.data.image
        valueLabel.text = item.data.value
        titleLabel.text = item.data.title
    }
}
