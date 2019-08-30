//
//  PostsListWireframe.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright (c) 2019 CHISW. All rights reserved.
//

import Foundation

typealias PostsListConfiguration = (PostsListPresenter) -> Void

class PostsListWireframe {
    class func setup(_ viewController: PostsListViewController,
                     withCoordinator coordinator: PostsListCoordinator,
                     configutation: PostsListConfiguration? = nil) {
        let interactor = PostsListInteractor()
        let presenter = PostsListPresenter(controller: viewController,
                                                          interactor: interactor,
                                                          coordinator: coordinator)
        viewController.presenter = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
}
