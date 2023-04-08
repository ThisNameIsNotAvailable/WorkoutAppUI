//
//  BaseController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

@objc extension BaseController {
    
    func addViews() {
        
    }
    
    func layoutViews() {
        
    }
    
    func configure() {
        view.backgroundColor = Resources.Colors.background
    }
    
    func navBarLeftButtonTapped() {
        print("Nav Bar left button tapped")
    }
    
    func navBarRightButtonTapped() {
        print("Nav Bar right button tapped")
    }
}

extension BaseController {
    func addNavBarButton(at position: NavBarPosition, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(Resources.Colors.active, for: .normal)
        button.setTitleColor(Resources.Colors.inactive, for: .disabled)
        button.titleLabel?.font = Resources.Fonts.helveticaRegular(with: 17)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonTapped), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonTapped), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
    func setTitleForNavBarButton(at position: NavBarPosition, with title: String) {
        switch position {
        case .left:
            (navigationItem.leftBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
        case .right:
            (navigationItem.rightBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
        }
    }
}
