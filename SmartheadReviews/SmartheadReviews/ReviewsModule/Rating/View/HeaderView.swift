//
//  HeaderView.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 22.07.2022.
//

import UIKit
import Combine

class HeaderView: UIView {
    
    //MARK: Private methods
    private enum Consts {
        static let grayColor = UIColor(red: 135/255, green: 153/255, blue: 180/255, alpha: 1.0)
        static let darkGrayColor = UIColor(red: 41/255, green: 59/255, blue: 85/255, alpha: 1)
    }
    
    private let viewModel: HeaderViewModel
    private var cancellableSet = Set<AnyCancellable>()
    
    private let headerLabel = UILabel()
    private let starsView = StarsView()
    private let ratingLabel = UILabel()
    private let reviewsCountLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let headerStackView = UIStackView()
    
    //MARK: inits
    init(viewModel: HeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        configureSubViews()
        setupSubviews()
        setupConstraints()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with model: HeaderModel) {
        self.headerLabel.text = model.title
        self.starsView.rating = model.rating
        self.ratingLabel.text = String(round(model.rating*10)/10)
        self.reviewsCountLabel.text = "\(model.reviewsCount) Reviews"
    }
    
}

private extension HeaderView {
    
    //MARK: init helpers
    
    func configureSubViews() {
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        headerLabel.textColor = Consts.darkGrayColor
        
        ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        ratingLabel.textColor = Consts.darkGrayColor
        
        reviewsCountLabel.font = UIFont.systemFont(ofSize: 12)
        reviewsCountLabel.textColor = Consts.grayColor
        
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .equalSpacing
        ratingStackView.spacing = 10
        
        headerStackView.axis = .vertical
        headerStackView.distribution = .equalSpacing
        headerStackView.alignment = .center
        headerStackView.spacing = 10
    }
    
    func setupSubviews() {
        self.addSubview(headerStackView)
        
        headerStackView.addArrangedSubview(headerLabel)
        
        ratingStackView.addArrangedSubview(starsView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        headerStackView.addArrangedSubview(ratingStackView)
        headerStackView.addArrangedSubview(reviewsCountLabel)
    }
    
    func setupConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        headerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        headerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        headerLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        reviewsCountLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
    }
    
    //MARK: Binding methods
    func bind() {
        viewModel.model.sink { [weak self] model in
            self?.configure(with: model)
        }.store(in: &cancellableSet)
    }
}
