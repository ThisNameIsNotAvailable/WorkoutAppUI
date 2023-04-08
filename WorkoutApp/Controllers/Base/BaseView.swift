//
//  BaseView.swift
//  WorkoutApp
//
//  Created by Alex on 06/04/2023.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseView {
    func addViews() {
        
    }
    
    func layoutViews() {
        
    }
    
    func configure() {
        
    }
}
