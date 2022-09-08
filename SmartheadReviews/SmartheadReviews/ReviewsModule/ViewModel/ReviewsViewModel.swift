//
//  ReviewsViewModel.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 21.07.2022.
//

import Foundation
import Combine

final class ReviewsViewModel {
    
    private let model = CurrentValueSubject<ReviewsModel, Never>(ReviewsModel())
    private var cancellableSet = Set<AnyCancellable>()
    
    public let onHeaderModel = CurrentValueSubject<HeaderModel, Never>(HeaderModel(title: "", rating: 0.0, reviewsCount: 0))
    public let onCollectionViewModel = CurrentValueSubject<[Review], Never>([])
    
    init() {
        bind()
    }
    
}

private extension ReviewsViewModel {
    func bind() {
        model.sink { [weak self] _ in
            self?.onCollectionViewModel.send([Review(rating: 5,
                                               date: "Aug 20, 2022",
                                               title: "Good!",
                                               review: "This is just great! materials are nice, the packaging is just a nice box so is very good for a gift and not so bad for the environment. It looks well made, no complaints.",
                                               author: "Tracey C."),
                                              Review(rating: 4,
                                                     date: "Jul 19, 2022",
                                                     title: "Nice!",
                                                     review: "Bought this for my Grandson for Christmas,I recently purchased the Mickey Mouse toy that stacks when he comes over,he loves both,I love that they are made with recycled milk cartons,Bpa free,lead free which is most important.",
                                                     author: "Bella M."),
                                             Review(rating: 5,
                                                    date: "Jul 14, 2022",
                                                    title: "Awesome product",
                                                    review: "I purchased this dump truck toy and tried it out with my daughter. I was a wreck when she took it apart, she just loved pulling the parts apart and putting them back together. We played with it for a bit and the kids had a lot of fun with it, especially my oldest who had never played with a dump truck before and was excited to try it out. She was even happy to help put it together. She liked that the parts were easy to put back together. She really liked.",
                                                    author: "Peter H."),
                                              Review(rating: 4,
                                                     date: "Jul 9, 2022",
                                                     title: "Nice toy!",
                                                     review: "I'm always looking for new ways to teach my children about the environment and what it means to be green. This is a great way to introduce them to the idea of recycling. The Dump Truck is a great toy for helping them understand the importance of saving the planet. I love that it's made from 100% recycled plastic and free from external coatings, eliminating the fear of toxins and lead paint. It's a great way for them to start teaching themselves about being green.",
                                                     author: "Mike L.")])
        }.store(in: &cancellableSet)
        
        model.sink { [weak self] _ in
            self?.onHeaderModel.send(HeaderModel(title: "Dump Truck Toy",
                                                 rating: 4.5,
                                                 reviewsCount: 4))
        } .store(in: &cancellableSet)
    }
}
