//
//  PostsTableViewController.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//

import UIKit
import Swinject

final class PostsTableViewController: UITableViewController, StoryboardInstantiable {
    
    private var viewModel: PostsListViewModel!

    // MARK: - Public
    func showPostsDetails(post: Post){
        
        if let postDetailsViewController = Assembler.sharedAssembler.resolver.resolve(PostDetailsViewController.self) {
            postDetailsViewController.post = post
            self.navigationController?.pushViewController(postDetailsViewController, animated: true)
        }
    }
 
    
    // MARK: - Lifecycle

    static func create(with viewModel: PostsListViewModel) -> PostsTableViewController {
        let view = PostsTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: PostsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
        
        viewModel.postSelected.observe(on: self) {
            [weak self] values in
            
            if let post = values {
                self?.showPostsDetails(post: post)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    // MARK: - Private

    private func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = PostsItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
        
        let postsTitle = NSLocalizedString("Posts", comment: "Posts")
        title = postsTitle
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PostsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsItemCell.reuseIdentifier, for: indexPath) as? PostsItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(PostsItemCell.self) with reuseIdentifier: \(PostsItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
    }
}
