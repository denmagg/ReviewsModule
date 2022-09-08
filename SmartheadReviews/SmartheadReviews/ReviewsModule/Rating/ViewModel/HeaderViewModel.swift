//
//  HeaderViewModel.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 22.07.2022.
//

import Foundation
import Combine

class HeaderViewModel {
    
    let model: CurrentValueSubject<HeaderModel, Never>
    private var cancellableSet = Set<AnyCancellable>()
    
    init(model: CurrentValueSubject<HeaderModel, Never>) {
        self.model = model
    }
}
