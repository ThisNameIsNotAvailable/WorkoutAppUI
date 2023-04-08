//
//  UIView+Extension.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

extension UIView {
    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0, y: frame.height - height, width: frame.width, height: height)
        self.addSubview(separator)
    }
    
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleTapIn), for: [.touchDown, .touchDragInside])
        button.addTarget(self, action: #selector(handleTapOut), for: [.touchUpInside, .touchUpOutside, .touchDragExit, .touchCancel, .touchDragOutside])
    }
    
    @objc func handleTapIn() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.55
        }
    }
    
    @objc func handleTapOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1
        }
    }
    
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
