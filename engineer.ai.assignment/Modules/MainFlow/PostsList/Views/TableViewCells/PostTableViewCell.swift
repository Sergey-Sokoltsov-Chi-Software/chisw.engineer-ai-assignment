//
//  PostTableViewCell.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var postTitleLabel: UILabel!
    @IBOutlet fileprivate weak var createdAtLabel: UILabel!
    @IBOutlet fileprivate weak var switcher: UISwitch!
    
    var switcherHandler: ((PostTableViewCell, Bool) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        createdAtLabel.text = nil
        switcher.isOn = false
    }
    
    final func configure(with post: PostResponseModel, isSelected: Bool) {
        postTitleLabel.text = post.title
        createdAtLabel.text = post.created_at
        switcher.isOn = isSelected
//        swicher.isOn = post.isSelected
    }
    
    // MARK: Action handlers
    @IBAction func switcherValuerChanged(sender: UISwitch) {
        switcherHandler?(self, sender.isOn)
    }
}
