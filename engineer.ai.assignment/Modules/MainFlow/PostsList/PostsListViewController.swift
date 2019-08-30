//
//  PostsListViewController.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright (c) 2019 CHISW. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController, AlertShowable  {
    // MARK: - Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //MARK: - Properties
    var presenter:  PostsListPresenter!
    
    // MARK: Private properties
    fileprivate var posts = [PostResponseModel]()
    fileprivate var selectedPostsIDs = [String]()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        fetchPosts()
    }
    
    // MARK: - UI
    
    private final func configureInterface() {
        localizeViews()
        configureTableView()
        adjustScreenTitle()
    }
    
    private final func configureTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // TODO: test this case - simulator with iOS version lower than 10 not installed.
            tableView.addSubview(refreshControl)
        }
        tableView.register(R.nib.postTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private final func refreshControlValueChanged(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        fetchPosts()
    }
    
    private final func localizeViews() {
        
    }
    
    // MARK: Private methods
    private final func fetchPosts() {
        view.showActivityIndicator(animated: true)
        presenter.getPosts { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            self.view.hideActivityIndicator(animated: true)
            switch result {
            case .success(let items):
                self.posts = items
                self.tableView.reloadData()
                break
            case .failure(let error):
                let title = "Error".localized()
                self.showAlert(title, error.localizedDescription)
                break
            }
        }
    }
    
    private final func adjustScreenTitle() {
        let noSelectionTitle = R.string.localizable.postsScreenTitle()
        let selectedCountTitle = R.string.localizable.selectedPostsCount() + "\(selectedPostsIDs.count)"
        title = selectedPostsIDs.isEmpty ? noSelectionTitle : selectedCountTitle
    }
    
    fileprivate final func handlePaginationIfNeeded(_ indexPath: IndexPath) {
        guard indexPath.row == posts.count - 1 else {
            return
        }
        guard presenter.hasMoreDataToFetch() else {
            return
        }
        presenter.handlePagingation() {[weak self] (result) in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let items):
                self.posts.append(contentsOf: items)
                self.tableView.reloadData()
                break
            case .failure(let error):
                let title = "Error".localized()
                self.showAlert(title, error.localizedDescription)
                break
            }
        }
    }
    
    fileprivate final func handlePostSelection(at indexPath: IndexPath, selected: Bool) {
        let post = posts[indexPath.row]
        var idsSet = Set(selectedPostsIDs)
        let postId = post.objectID
        if selected {
            idsSet.insert(postId)
        } else {
            idsSet.remove(postId)
        }
        selectedPostsIDs = Array(idsSet)
        adjustScreenTitle()
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: UITableViewDataSource
extension PostsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let postCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postTableViewCell, for: indexPath)!
        let isSelected = selectedPostsIDs.contains(post.objectID)
        postCell.configure(with: post, isSelected: isSelected)
        postCell.switcherHandler = { [unowned self] (cell, selected) in
            guard let path = tableView.indexPath(for: cell) else {
                return
            }
            self.handlePostSelection(at: path, selected: selected)
        }
        return postCell
    }
}

// MARK: UITableViewDelegate
extension PostsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let isSelected = selectedPostsIDs.contains(post.objectID)
        handlePostSelection(at: indexPath, selected: !isSelected)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        handlePaginationIfNeeded(indexPath)
    }
}
