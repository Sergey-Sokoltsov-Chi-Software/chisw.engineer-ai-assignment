//
//  AppCoordinator.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import Foundation


import UIKit

protocol AppCoordinatorProtocol {
    func showMainFlow()
}

class AppCoordinator {
    //    MARK: - Private
    private let window: UIWindow
    private let router: AppRouter
    
    private var mainCoordinator: MainFlowCoordinator?
    
    //    MARK: Init
    init(window: UIWindow) {
        self.window = window
        router = AppRouter(window: window)
    }
    
    final func setup() {
        configureAndShowMainFlow()
        window.makeKeyAndVisible()
    }
    
    final fileprivate func configureAndShowMainFlow() {
        let navigationController = UINavigationController()
        let mainRouter = MainRouter(withNavigationController: navigationController)
        mainCoordinator = MainFlowCoordinator(withRouter: mainRouter, appCoordinator: self)
        mainCoordinator?.start()
        router.setRootController(navigationController)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func showMainFlow() {
        configureAndShowMainFlow()
    }
}
