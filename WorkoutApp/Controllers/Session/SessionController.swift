//
//  SessionController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

class SessionController: BaseController {
    
    private let timerView = TimerView()
    
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
            setTitleForNavBarButton(at: .left, with: "Start")
        }
    }
    
    override func navBarRightButtonTapped() {
        timerView.stopTimer()
        timerView.state = .stopped
        setTitleForNavBarButton(at: .right, with: "Start")
    }
}

extension SessionController {
    override func addViews() {
        super.addViews()
        
        view.addView(timerView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            timerView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    override func configure() {
        super.configure()
        
        title = "High Intensity Cardio"
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.session
        
        addNavBarButton(at: .left, with: "Start")
        addNavBarButton(at: .right, with: "Finish")
        
        timerView.configure(with: timerDuration, progress: 0)
    }
}
