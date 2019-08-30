//
//  PostsListPresenter.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright (c) 2019 CHISW. All rights reserved.
//

import UIKit

class PostsListPresenter {
    
    //MARK: - Init
    required init(controller: PostsListViewController,
                  interactor: PostsListInteractor,
                  coordinator: PostsListCoordinator) {
        self.coordinator = coordinator
        self.controller = controller
        self.interactor = interactor
    }
    
    //MARK: - Private -
    fileprivate let coordinator: PostsListCoordinator
    fileprivate unowned var controller: PostsListViewController
    fileprivate var interactor: PostsListInteractor
    
    
    // MARK: Public methods
    final func hasMoreDataToFetch() -> Bool {
        return interactor.hasMoreDataToFetch()
    }
    
    final func getPosts(completion: @escaping (Result<[PostResponseModel], Error>) -> Void) {
        interactor.getPosts(completion: completion)
    }
    
    final func handlePagingation(completion: @escaping (Result<[PostResponseModel], Error>) -> Void) {
        interactor.handlePagingation(completion: completion)
    }
}
