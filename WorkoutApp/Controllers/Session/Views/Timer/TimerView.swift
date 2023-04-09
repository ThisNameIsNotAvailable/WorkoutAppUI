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
    
    private let elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Elapsed Time"
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 14)
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    private let elapsedTimeValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 46)
        label.textColor = Resources.Colors.darkGrey
        return label
    }()
    
    private let remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remaining Time"
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 13)
        label.textColor = Resources.Colors.inactive
        return label
    }()
    
    private let remainingTimeValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Fonts.helveticaRegular(with: 13)
        label.textColor = Resources.Colors.darkGrey
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private let progressView = ProgressView()
    
    private let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    private let completedPercentView = PercentView()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.separator
        return view
    }()
    private let remainingPercentView = PercentView()
    
    private var timer = Timer()
    private var timerProgress: CGFloat = 0
    private var timerDuration = 0.0
    
    public var state: TimerState = .stopped
    public var callBack: (()->Void)?
    
    func configure(with duration: Double, progress: Double) {
        timerDuration = duration
        let tempCurrentValue = progress > duration ? duration : progress
        
        let goalValueDivider = duration == 0 ? 1 : duration
        let percent = tempCurrentValue / goalValueDivider
        let roundedPercent = Int(round(percent * 100))
        
        elapsedTimeValueLabel.text = getDisplayedTime(from: Int(tempCurrentValue))
        remainingTimeValueLabel.text = getDisplayedTime(from: Int(duration) - Int(tempCurrentValue))
        
        completedPercentView.configure(with: roundedPercent, title: "completed".uppercased())
        remainingPercentView.configure(with: 100-roundedPercent, title: "remaining".uppercased())
        
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
                strongSelf.callBack?()
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
            strongSelf.timerProgress -= strongSelf.timerDuration * 0.03
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
        [
            elapsedTimeLabel,
            elapsedTimeValueLabel,
            remainingTimeLabel,
            remainingTimeValueLabel
        ].forEach { el in
            stackView.addArrangedSubview(el)
        }
        addView(stackView)
        
        [
            completedPercentView,
            separator,
            remainingPercentView
        ].forEach { el in
            bottomStackView.addArrangedSubview(el)
        }
        addView(bottomStackView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
            stackView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 35),
            bottomStackView.widthAnchor.constraint(equalToConstant: 175),
            
            separator.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    override func configure() {
        super.configure()
    }
}

private extension TimerView {
    func getDisplayedTime(from value: Int) -> String {
        let seconds = value % 60
        let minutes = (value / 60) % 60
        let hours = (value / 3600)
        
        let secondStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minuteStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hourStr = hours < 10 ? "0\(hours)" : "\(hours)"
        
        return hours == 0 ? "\(minuteStr):\(secondStr)" : "\(hourStr):\(minuteStr):\(secondStr)"
    }
}
