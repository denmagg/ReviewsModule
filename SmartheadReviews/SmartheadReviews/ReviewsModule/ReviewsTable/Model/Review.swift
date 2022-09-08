//
//  Review.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 25.07.2022.
//

import Foundation

struct Review: Decodable, Hashable {
    var rating: Int
    var date: String
    var title: String
    var review: String
    var author: String
}
