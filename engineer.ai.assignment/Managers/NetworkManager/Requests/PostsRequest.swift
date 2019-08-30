//
//  PostsRequest.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import Foundation

class PostsRequest: BaseRequest {
    init(page: String, tags: String) {
        super.init()
        path = "search_by_date"
        headers = [
            "Content-Type": "application/json"
        ]
        queryParameters = [
            "page": page,
            "tags": tags
        ]
    }
}
