//
//  MainRouter.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

class MainRouter: NavigationRouting {
    var navigationController: UINavigationController
    var topViewController: UIViewController
    
    //    MARK: Init
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        topViewController = navigationController.topViewController ?? navigationController
    }
}
