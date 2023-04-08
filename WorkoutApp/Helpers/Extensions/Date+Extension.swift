//
//  Date+Extension.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import Foundation

extension Date {
    static var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.firstWeekday = 2
        return cal
    }
    var startOfWeek: Date {
        let components = Self.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        guard let firstDay = Self.calendar.date(from: components) else {
            return self
        }
        return Self.calendar.date(byAdding: .day, value: 0, to: firstDay) ?? self
    }
    
    func goForward(to days: Int) -> Date {
        return Self.calendar.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func stripTime() -> Date {
        let components = Self.calendar.dateComponents([.year, .month, .day], from: self)
        return Self.calendar.date(from: components) ?? self
    }
}
