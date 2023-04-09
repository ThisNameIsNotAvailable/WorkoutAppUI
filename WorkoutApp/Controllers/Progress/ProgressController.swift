//
//  ProgressController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

class ProgressController: BaseController {
    
    private let dailyPerformanceView = DailyPerformanceView(with: "Daily Performance", buttonTitle: "Last 7 days".uppercased())
    
    private let monthlyPerformanceView = MonthlyPerformanceView(with: "Monthly Performance", buttonTitle: "Last 10 months".uppercased())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Workout Progress"
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.progress
        
        addNavBarButton(at: .left, with: "Export")
        addNavBarButton(at: .right, with: "Details")
    }
    
    override func addViews() {
        super.addViews()
        
        view.addView(dailyPerformanceView)
        view.addView(monthlyPerformanceView)
    }

    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            dailyPerformanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyPerformanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dailyPerformanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyPerformanceView.heightAnchor.constraint(equalTo: dailyPerformanceView.widthAnchor, multiplier: 0.68),
            
            monthlyPerformanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            monthlyPerformanceView.topAnchor.constraint(equalTo: dailyPerformanceView.bottomAnchor, constant: 15),
            monthlyPerformanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            monthlyPerformanceView.heightAnchor.constraint(equalTo: dailyPerformanceView.widthAnchor, multiplier: 1.06)
        ])
        
        dailyPerformanceView.configure(with: [
            .init(value: "1", heightMultiplier: 0.2, title: "MON"),
            .init(value: "2", heightMultiplier: 0.4, title: "TUE"),
            .init(value: "3", heightMultiplier: 0.6, title: "WED"),
            .init(value: "4", heightMultiplier: 0.8, title: "THU"),
            .init(value: "5", heightMultiplier: 1, title: "FRI"),
            .init(value: "3", heightMultiplier: 0.6, title: "SAT"),
            .init(value: "2", heightMultiplier: 0.4, title: "SUN")
        ])
        
        monthlyPerformanceView.configure(with: [
            .init(title: "MAR", value: 45),
            .init(title: "APR", value: 55),
            .init(title: "MAY", value: 60),
            .init(title: "JUN", value: 65),
            .init(title: "JUL", value: 70),
            .init(title: "AUG", value: 80),
            .init(title: "SEP", value: 65),
            .init(title: "OCT", value: 45),
            .init(title: "NOV", value: 30),
            .init(title: "DEC", value: 15)
        ], topChartOffset: 10)
    }
}


