//
//  ReviewCell.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 25.07.2022.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    enum Consts {
        static let cellId = "ReviewCell"
        static let grayColor = UIColor(red: 135/255, green: 153/255, blue: 180/255, alpha: 1.0)
        static let darkGrayColor = UIColor(red: 41/255, green: 59/255, blue: 85/255, alpha: 1)
    }
    
    private let ratingView = StarsView()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let reviewLabel = UILabel()
    private let authorLabel = UILabel()
    private let separator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        configureSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Review, isSeparatorHidden: Bool = false) {
        separator.isHidden = isSeparatorHidden
        ratingView.rating = Float(model.rating)
        dateLabel.text = model.date
        titleLabel.text = model.title
        reviewLabel.text = model.review
        authorLabel.text = model.author
    }
    
}

private extension ReviewCell {
    
    func setupSubviews() {
        contentView.addSubview(ratingView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(reviewLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(separator)
    }
    
    func configureSubviews() {
        dateLabel.textColor = Consts.grayColor
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = Consts.darkGrayColor

        reviewLabel.numberOfLines = 0
        reviewLabel.font = UIFont.systemFont(ofSize: 14)
        reviewLabel.textColor = Consts.darkGrayColor
        
        authorLabel.textColor = Consts.grayColor
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        
        separator.backgroundColor = Consts.grayColor.withAlphaComponent(0.2)
        separator.backgroundColor = .gray
    }
    
    func setupConstraints() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        reviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        reviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 20).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
}
