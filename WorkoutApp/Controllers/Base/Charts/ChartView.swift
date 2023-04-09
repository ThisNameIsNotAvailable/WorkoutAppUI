//
//  ChartView.swift
//  WorkoutApp
//
//  Created by Alex on 09/04/2023.
//

import UIKit

final class ChartView: BaseView {
    
    private let ySeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.separator
        return view
    }()
    
    private let xSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.separator
        return view
    }()
    
    override func addViews() {
        super.addViews()
        
        addView(ySeparator)
        addView(xSeparator)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            ySeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            ySeparator.topAnchor.constraint(equalTo: topAnchor),
            ySeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            ySeparator.widthAnchor.constraint(equalToConstant: 1),
            
            xSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            xSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            xSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            xSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(with data: [ChartsView.ChartsData], topChartOffset: Int) {
        layoutIfNeeded()
        drawDashLines()
        drawChart(with: data, topChartOffset: topChartOffset)
    }
}

private extension ChartView {
    
    func drawDashLines(with counts: CGFloat = 9) {
        (0...8).map{ CGFloat($0) }.forEach { i in
            drawDashLine(at: bounds.size.height / counts * i)
        }
    }
    
    func drawDashLine(at yPosition: CGFloat) {
        let startPoint = CGPoint(x: 0, y: yPosition)
        let endPoint = CGPoint(x: bounds.size.width, y: yPosition)
        
        let dashPath = CGMutablePath()
        dashPath.addLines(between: [startPoint, endPoint])
        
        let dashLayer = CAShapeLayer()
        dashLayer.path = dashPath
        dashLayer.strokeColor = Resources.Colors.separator.cgColor
        dashLayer.lineWidth = 1
        dashLayer.lineDashPattern = [6, 3]
        
        layer.addSublayer(dashLayer)
    }
    
    func drawChart(with data: [ChartsView.ChartsData], topChartOffset: Int) {
        guard let maxValue = data.sorted(by: { $0.value > $1.value }).first?.value else { return }
        let valuePoints = data.enumerated().map( { CGPoint(x: CGFloat($0), y: CGFloat($1.value)) } )
        let pointHeight = bounds.size.height / CGFloat(maxValue + topChartOffset)
        
        let points = valuePoints.map {
            let x = bounds.size.width / CGFloat(valuePoints.count - 1) * $0.x
            let y = bounds.size.height - $0.y * pointHeight
            return CGPoint(x: x, y: y)
        }
        
        let chartPath = UIBezierPath()
        chartPath.move(to: points[0])
        
        points.forEach {
            chartPath.addLine(to: $0)
            drawChartDots(at: $0)
        }
        
        let chartLayer = CAShapeLayer()
        chartLayer.path = chartPath.cgPath
        chartLayer.fillColor = UIColor.clear.cgColor
        chartLayer.strokeColor = Resources.Colors.active.cgColor
        chartLayer.lineWidth = 3
        chartLayer.strokeEnd = 1
        chartLayer.lineCap = .round
        chartLayer.lineJoin = .round
        
        layer.addSublayer(chartLayer)
    }
    
    func drawChartDots(at point: CGPoint) {
        let dotPath = UIBezierPath()
        dotPath.move(to: point)
        dotPath.addLine(to: point)
        
        let dotLayer = CAShapeLayer()
        dotLayer.path = dotPath.cgPath
        dotLayer.strokeColor = Resources.Colors.active.cgColor
        dotLayer.lineCap = .round
        dotLayer.lineWidth = 10
        
        layer.addSublayer(dotLayer)
    }
}
