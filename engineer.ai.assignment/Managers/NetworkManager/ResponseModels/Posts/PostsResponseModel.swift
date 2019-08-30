//
//  PostsResponseModel.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import Foundation
struct PostsResponseModel: Codable {
    var hits: [PostResponseModel]?
    var page: Int?
    var nbPages: Int?
    var hitsPerPage: Int?
}

struct PostResponseModel: Codable {
    var objectID: String
    var created_at: String?
    var title: String?
//    var isSelected: Bool = false
}
