//
//  PostsListInteractor.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright (c) 2019 CHISW. All rights reserved.
//

import Foundation

protocol PostsListInteractorProtocol {
    func hasMoreDataToFetch() -> Bool
    func getPosts(completion: @escaping (Result<[PostResponseModel], Error>) -> Void)
    func handlePagingation(completion: @escaping (Result<[PostResponseModel], Error>) -> Void)
}

class PostsListInteractor {
    weak var presenter: PostsListPresenter!
    fileprivate var page: Int = 0
    fileprivate var pagesCount: Int = 1
    
    private var request: URLSessionDataTask?
    
    fileprivate final func fetchPostsList(page: Int, completion: @escaping (Result<[PostResponseModel], Error>) -> Void) {
        let postsRequest = PostsRequest(page: "\(page)", tags: "story")
        request = NetworkManager().execute(type: PostsResponseModel.self, request: postsRequest) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            self.request = nil
            switch result {
            case .success(let model):
                guard let posts = model.hits else {
                    completion(.failure(NetworkError.commonError))
                    return
                }
                self.pagesCount = model.nbPages ?? 0
                completion(.success(posts))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}

extension PostsListInteractor: PostsListInteractorProtocol {
    func hasMoreDataToFetch() -> Bool {
        return page + 1 <= pagesCount
    }
    
    func getPosts(completion: @escaping (Result<[PostResponseModel], Error>) -> Void) {
        request?.cancel()
        page = 0
        fetchPostsList(page: page, completion: completion)
    }
    
    func handlePagingation(completion: @escaping (Result<[PostResponseModel], Error>) -> Void) {
        guard request == nil, hasMoreDataToFetch() == true else {
            completion(.success([PostResponseModel]()))
            return
        }
        page += 1
        fetchPostsList(page: page, completion: completion)
    }
}
