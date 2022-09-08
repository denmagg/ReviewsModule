//
//  Section.swift
//  SmartheadReviews
//
//  Created by Денис Медведев on 26.07.2022.
//

import Foundation
import UIKit

struct Section: Decodable, Hashable {
    let items: [Review]
}
