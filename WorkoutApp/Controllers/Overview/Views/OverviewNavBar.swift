//
//  OverviewNavBar.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import UIKit

final class OverviewNavBar: BaseView {
    private let titleLabel = UILabel()
    private let allWorkoutsButton = WAButton(with: .secondary, and: Resources.Strings.Overview.allWorkoutsButton)
    private let addButton = UIButton()
    private let weekView: UIView = WeekView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBottomBorder(with: Resources.Colors.separator, height: 1)
    }
    
    func addTapped(_ action: Selector, with target: Any?) {
        addButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func allWorkoutsTapped(_ action: Selector, with target: Any?) {
        allWorkoutsButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension OverviewNavBar {
    override func addViews() {
        super.addViews()
        
        addView(titleLabel)
        addView(allWorkoutsButton)
        addView(addButton)
        addView(weekView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 28),
            addButton.widthAnchor.constraint(equalToConstant: 28),
            
            allWorkoutsButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            allWorkoutsButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -16),
            allWorkoutsButton.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: allWorkoutsButton.leadingAnchor),
            
            weekView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            weekView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weekView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weekView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            weekView.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .white
        
        titleLabel.text = "Today"
        titleLabel.textColor = Resources.Colors.darkGrey
        titleLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        
        addButton.setImage(Resources.Images.Common.add, for: .normal)
    }
}
