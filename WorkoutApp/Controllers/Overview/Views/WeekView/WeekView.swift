//
//  WeekView.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import UIKit

final class WeekView: BaseView {
    private let stack = UIStackView()
    private let calendar = Date.calendar
}

extension WeekView {
    override func addViews() {
        super.addViews()
        
        addView(stack)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        var weekdays = calendar.shortStandaloneWeekdaySymbols
        
        if calendar.firstWeekday == 2 {
            let first = weekdays.remove(at: 0)
            weekdays.append(first)
        }
        
        weekdays.enumerated().forEach { index, day in
            let view = WeekdayView()
            view.configure(with: index, and: day.uppercased())
            stack.addArrangedSubview(view)
        }
    }
}
