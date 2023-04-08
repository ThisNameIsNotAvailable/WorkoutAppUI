//
//  TimerView.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import UIKit

enum TimerState {
    case running
    case paused
    case stopped
}

final class TimerView: BaseInfoView {
    private let progressView = ProgressView()
    
    private var timer = Timer()
    private var timerProgress: CGFloat = 0
    private var timerDuration = 0.0
    
    public var state: TimerState = .stopped
    
    func configure(with duration: Double, progress: Double) {
        timerDuration = duration
        let tempCurrentValue = progress > duration ? duration : progress
        
        let goalValueDivider = duration == 0 ? 1 : duration
        let percent = tempCurrentValue / goalValueDivider
        
        progressView.drawProgress(with: CGFloat(percent))
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            strongSelf.timerProgress += 0.01
            if strongSelf.timerProgress > strongSelf.timerDuration {
                strongSelf.timerProgress = strongSelf.timerDuration
                timer.invalidate()
            }
            
            strongSelf.configure(with: strongSelf.timerDuration, progress: strongSelf.timerProgress)
        })
    }
    
    func pauseTimer() {
        timer.invalidate()
    }
    
    func stopTimer() {
        guard self.timerProgress > 0 else {
            return
        }
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            strongSelf.timerProgress -= 0.1
            if strongSelf.timerProgress <= 0 {
                strongSelf.timerProgress = 0
                timer.invalidate()
            }
            
            strongSelf.configure(with: strongSelf.timerDuration, progress: strongSelf.timerProgress)
        })
    }
}

extension TimerView {
    override func addViews() {
        super.addViews()
        
        addView(progressView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor)
        ])
    }
    
    override func configure() {
        super.configure()
    }
}
