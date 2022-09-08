//
//  ReviewsViewController.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 21.07.2022.
//

import UIKit
import Combine

final class ReviewsViewController: UIViewController {
    
    private var viewModel: ReviewsViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    private lazy var headerView: HeaderView = {
        let viewModel = HeaderViewModel(model: viewModel.onHeaderModel)
        return HeaderView(viewModel: viewModel)
    }()
    private lazy var reviewsCollectionView: ReviewsCollectionView = {
        let viewModel = ReviewsCollectionViewModel(model: viewModel.onCollectionViewModel)
        return ReviewsCollectionView(viewModel: viewModel)
    }()

    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupConstraints()
    }

}

private extension ReviewsViewController {
    //MARK: init helpers
    private func setupSubviews() {
        self.view.addSubview(headerView)
        self.view.addSubview(reviewsCollectionView)
    }
    
    private func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        reviewsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        reviewsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        reviewsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        reviewsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        reviewsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
