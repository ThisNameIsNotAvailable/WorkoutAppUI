//
//  SettingsController.swift
//  WorkoutApp
//
//  Created by Alex on 04/04/2023.
//

import UIKit

class SettingsController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.settings
    }


}


