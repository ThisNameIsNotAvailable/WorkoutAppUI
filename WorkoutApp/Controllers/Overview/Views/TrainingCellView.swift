//
//  TrainingCellView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

enum CellRoundedType {
    case top
    case bottom
    case all
    case notRounded
}

final class TrainingCellView: UICollectionViewCell {
    static let identifier = "TrainingCellView"
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.Overview.checkmarkNotDone
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 17)
        label.textColor = Resources.Colors.darkGrey
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.helveticaRegular(with: 13)
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.Overview.rightArrow
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addView(checkmarkImageView)
        addView(rightArrowImageView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        addView(stackView)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            checkmarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 28),
            checkmarkImageView.widthAnchor.constraint(equalTo: checkmarkImageView.heightAnchor, multiplier: 1),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            rightArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: 12),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 7),
            rightArrowImageView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    func configure(with title: String, and subtitle: String, isDone: Bool, roundedType: CellRoundedType) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        checkmarkImageView.image = isDone ? Resources.Images.Overview.checkmarkDone : Resources.Images.Overview.checkmarkNotDone
        switch roundedType {
        case .top:
            self.roundCorners([.topLeft, .topRight], radius: 5)
        case .bottom:
            self.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        case .all:
            self.roundCorners([.allCorners], radius: 5)
        case .notRounded:
            self.roundCorners([.allCorners], radius: 0)
        }
    }
    
    func configure() {
        backgroundColor = .white
    }
}
