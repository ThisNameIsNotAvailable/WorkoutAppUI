//
//  WeekDayView.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import UIKit

extension WeekView {
    
    final class WeekdayView: BaseView {
        private let dayLabel = UILabel()
        private let dateLabel = UILabel()
        private let stackView = UIStackView()
        
        func configure(with index: Int, and name: String) {
            let startOfWeek = Date().startOfWeek
            let currentDay = startOfWeek.goForward(to: index)
            let day = Calendar.current.component(.day, from: currentDay)
            let isToday = currentDay.stripTime() == Date().stripTime()
            
            backgroundColor = isToday ? Resources.Colors.active : Resources.Colors.background
            dayLabel.text = name
            dayLabel.textColor = isToday ? .white : Resources.Colors.inactive
            dateLabel.text = "\(day)"
            dateLabel.textColor = isToday ? .white : Resources.Colors.inactive
        }
    }
    
}


extension WeekView.WeekdayView {
    override func addViews() {
        super.addViews()
        
        addView(stackView)
        
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .red
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        dayLabel.font = Resources.Fonts.helveticaRegular(with: 9)
        dayLabel.textAlignment = .center
        
        dateLabel.font = Resources.Fonts.helveticaRegular(with: 15)
        dateLabel.textAlignment = .center
        
        stackView.spacing = 3
        stackView.axis = .vertical
    }
}
