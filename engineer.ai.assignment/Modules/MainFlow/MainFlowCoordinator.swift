//
//  MainFlowCoordinator.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

class MainFlowCoordinator {
    //    MARK: Private
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    
    init(withRouter router: MainRouter, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }
    
    final func start() {
        guard let vc = R.storyboard.postsList.postsListViewController() else {
            fatalError("Can not instantiate postsListViewController") }
        PostsListWireframe.setup(vc, withCoordinator: self)
        router.setRoot(vc, animated: false)
    }
}

extension MainFlowCoordinator: PostsListCoordinator {
    
}
