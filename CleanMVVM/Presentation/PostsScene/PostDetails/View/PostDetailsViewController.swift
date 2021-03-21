//
//  PostDetailsViewController.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 19/03/2021. 
//  
//

import UIKit

final class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryboardInstantiable {



    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userUserNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userContainer: UIView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var userLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var commentsLoadingIndicator: UIActivityIndicatorView!
    // MARK: - Lifecycle

    private var viewModel: PostDetailsViewModel!
    
    static func create(with viewModel: PostDetailsViewModel) -> PostDetailsViewController {
        let view = PostDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: PostDetailsViewModel) {
        
        viewModel.user.observe(on: self) {
            [weak self] values in
            
            self?.userNameLabel.text = values?.name
            self?.userUserNameLabel.text = values?.username
            self?.userEmailLabel.text = values?.email
            self?.userLoadingIndicator.hidesWhenStopped = true
            self?.userLoadingIndicator.stopAnimating()
            self?.userContainer.isHidden = false
        }
        
        
        viewModel.items.observe(on: self) { [weak self] items in
            self?.tableView.reloadData()
            self?.tableViewHeight.constant = CGFloat(items.count) * CommentsItemCell.height
            self?.commentsLoadingIndicator.hidesWhenStopped = true
            self?.commentsLoadingIndicator.stopAnimating()
            
            self?.tableView.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateUser()
        viewModel.updateComments()
        userContainer.isHidden = true
        tableView.isHidden = true
        
        userLoadingIndicator.startAnimating()
        commentsLoadingIndicator.startAnimating()
    }

    // MARK: - Private

    private func setupViews() {
        title = "Post Details"
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        tableView.isScrollEnabled = false
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = CommentsItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
        view.accessibilityIdentifier = AccessibilityIdentifier.postDetailsView
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PostDetailsViewController {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsItemCell.reuseIdentifier, for: indexPath) as? CommentsItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(CommentsItemCell.self) with reuseIdentifier: \(CommentsItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
}
