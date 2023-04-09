//
//  SessionController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

class SessionController: BaseController {
    
    private let timerView = TimerView()
    private let statsView = StatsView(with: "Workout stats")
    private let stepsView = StepsView(with: "Steps Counter")
    
    private let timerDuration = 13.0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func navBarLeftButtonTapped() {
        if timerView.state == .stopped || timerView.state == .paused {
            timerView.startTimer()
            timerView.state = .running
            setTitleForNavBarButton(at: .left, with: "Pause")
        } else {
            timerView.pauseTimer()
            timerView.state = .paused
            setTitleForNavBarButton(at: .left, with: "Start     ")
        }
    }
    
    override func navBarRightButtonTapped() {
        timerView.stopTimer()
        timerView.state = .stopped
        setTitleForNavBarButton(at: .left, with: "Start     ")
    }
}

extension SessionController {
    override func addViews() {
        super.addViews()
        
        view.addView(timerView)
        view.addView(statsView)
        view.addView(stepsView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statsView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 11),
            statsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -7.5),
            
            stepsView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 7.5),
            stepsView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 11),
            stepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stepsView.heightAnchor.constraint(equalTo: statsView.heightAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
        
        title = "High Intensity Cardio"
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.session
        
        addNavBarButton(at: .left, with: "Start     ")
        addNavBarButton(at: .right, with: "Finish")
        timerView.callBack = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.navBarRightButtonTapped()
            }
        }
        timerView.configure(with: timerDuration, progress: 0)
        statsView.configure(with: [
            .heartRate(value: "155"),
            .averagePace(value: "8'20''"),
            .totalSteps(value: "7,682"),
            .totalDistance(value: "8.25")])
        stepsView.configure(with: [
            .init(value: "8K", heightMultiplier: 1, title: "2/14"),
            .init(value: "7K", heightMultiplier: 0.8, title: "2/15"),
            .init(value: "5K", heightMultiplier: 0.7, title: "2/16"),
            .init(value: "6K", heightMultiplier: 0.6, title: "2/17")
        ])
    }
}
