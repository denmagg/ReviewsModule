//
//  ReviewsCollectionView.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 25.07.2022.
//

import UIKit
import Combine

class ReviewsCollectionView: UIView, UICollectionViewDelegateFlowLayout {

    private let viewModel: ReviewsCollectionViewModel
    private var cancellableSet = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Review>?
    private var collectionView: UICollectionView?
    
    //MARK: inits
    init(viewModel: ReviewsCollectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupCollectionView()
        dataSource = configureDataSource()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Review>? {
        
        guard let collectionView = collectionView else { return nil }

        let dataSource = UICollectionViewDiffableDataSource<Section, Review>(collectionView: collectionView) { [weak self] (collectionView, indexPath, model) -> UICollectionViewCell? in
            guard self != nil else { return UICollectionViewCell() }
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.Consts.cellId, for: indexPath) as? ReviewCell
                cell?.configure(with: model, isSeparatorHidden: true)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.Consts.cellId, for: indexPath) as? ReviewCell
                cell?.configure(with: model)
                return cell
            }
        }
        return dataSource
    }
    
    private func reloadData(reviews: [Review]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Review>()
        snapShot.appendSections([Section(items: reviews)])
        snapShot.appendItems(reviews)
        
        dataSource?.apply(snapShot)
    }
}

private extension ReviewsCollectionView {
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let collectionView = collectionView else { return }
        self.addSubview(collectionView)
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.Consts.cellId)
        collectionView.dataSource = dataSource
    }
    
    // MARK: - Setup Layout
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createSection())
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func bind() {
        viewModel.model.sink { [weak self] reviews in
            self?.reloadData(reviews: reviews)
        }.store(in: &cancellableSet)
    }
}
