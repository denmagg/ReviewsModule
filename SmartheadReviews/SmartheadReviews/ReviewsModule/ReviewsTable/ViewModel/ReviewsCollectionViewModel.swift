//
//  ReviewsCollectionViewModel.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 25.07.2022.
//

import Foundation
import Combine

class ReviewsCollectionViewModel {
    
    let model: CurrentValueSubject<[Review], Never>
    private var cancellableSet = Set<AnyCancellable>()
    
    init(model: CurrentValueSubject<[Review], Never>) {
        self.model = model
    }
    
}
