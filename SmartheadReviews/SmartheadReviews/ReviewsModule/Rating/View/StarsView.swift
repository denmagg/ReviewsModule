//
//  StarsView.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 22.07.2022.
//

import UIKit

final class StarsView: UIView {

    //MARK: Public properties
    public var rating: Float? {
        didSet {
            updateStars(forRating: rating)
        }
    }
    
    //MARK: Private properties
    private enum Consts {
        static let starImage = UIImage(named: "StarEmpty")
        static let starFilledImage = UIImage(named: "StarFilled")
    }
    
    private var emptyStarsArray: [UIImageView] = []
    private var filledStarsArray: [UIImageView] = []
    private var starsStackView = UIStackView()
    
    //MARK: inits
    init() {
        super.init(frame: .zero)
        self.initStarArrays()
        self.setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarsView {
    
    //MARK: init helpers
    private func initStarArrays() {
        for _ in 0..<5 {
            emptyStarsArray.append(UIImageView(image: Consts.starImage))
            filledStarsArray.append(UIImageView(image: Consts.starFilledImage))
        }
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 5.5).isActive = true
        
        starsStackView = UIStackView(frame: self.bounds)
        starsStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        starsStackView.spacing = 3
        starsStackView.distribution = .fillEqually
        starsStackView.axis = .horizontal
        
        self.addSubview(starsStackView)
        
        for (index, star) in emptyStarsArray.enumerated() {
            starsStackView.addArrangedSubview(star)
            
            star.addSubview(filledStarsArray[index])
            star.contentMode = .scaleAspectFit
            
            filledStarsArray[index].contentMode = .scaleAspectFit
            filledStarsArray[index].isHidden = true
                        
            filledStarsArray[index].translatesAutoresizingMaskIntoConstraints = false
            filledStarsArray[index].topAnchor.constraint(equalTo: star.topAnchor).isActive = true
            filledStarsArray[index].bottomAnchor.constraint(equalTo: star.bottomAnchor).isActive = true
            filledStarsArray[index].leadingAnchor.constraint(equalTo: star.leadingAnchor).isActive = true
            filledStarsArray[index].trailingAnchor.constraint(equalTo: star.trailingAnchor).isActive = true
        }
    }
    
    //MARK: Binding methods
    private func updateStars(forRating rating: Float?) {
        guard let rating = rating else { return }
        
        for i in 0..<self.filledStarsArray.count {
            let imageView = filledStarsArray[i]
            
            if rating >= Float(i+1) {
                imageView.layer.mask = nil
                imageView.isHidden = false
            } else if rating > Float(i) && rating < Float(i+1) {
                // Set mask layer for full image
                let maskLayer = CALayer()
                maskLayer.frame = CGRect(x: 0,
                                         y: 0,
                                         width: CGFloat(rating-Float(i))*imageView.frame.size.width,
                                         height: imageView.frame.size.height)
                maskLayer.backgroundColor = UIColor.black.cgColor
                imageView.layer.mask = maskLayer
                imageView.isHidden = false
            } else {
                imageView.layer.mask = nil;
                imageView.isHidden = true
            }
        }
    }
}
