//
//  SecondaryButton.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

public enum WAButtonType {
    case primary
    case secondary
}

final class WAButton: UIButton {
    
    private let label = UILabel()
    private let iconView = UIImageView()
    
    private let type: WAButtonType
    
    init(with type: WAButtonType, and title: String) {
        self.type = type
        super.init(frame: .zero)
        label.text = title
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WAButton {
    func addViews() {
        addView(label)
        addView(iconView)
    }
    
    func layoutViews() {
        var horizontalOffset: CGFloat {
            switch type {
            case .primary:
                return 0
            case .secondary:
                return 10
            }
        }
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalOffset),
            iconView.heightAnchor.constraint(equalToConstant: 5),
            iconView.widthAnchor.constraint(equalToConstant: 10),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2 * horizontalOffset)
        ])
    }
    
    func configure() {
        label.textAlignment = .center
        
        iconView.image = Resources.Images.Common.downArrow?.withRenderingMode(.alwaysTemplate)
        
        switch type {
        case .primary:
            label.textColor = Resources.Colors.inactive
            iconView.tintColor = Resources.Colors.inactive
            label.font = Resources.Fonts.helveticaRegular(with: 13)
            label.text = label.text?.uppercased()
        case .secondary:
            backgroundColor = Resources.Colors.secondary
            layer.cornerRadius = 14
            label.textColor = Resources.Colors.active
            iconView.tintColor = Resources.Colors.active
            label.font = Resources.Fonts.helveticaRegular(with: 15)
        }
        makeSystem(self)
    }
}
