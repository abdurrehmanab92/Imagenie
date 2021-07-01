//
//  Constants.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import Foundation

struct Identifier{
    struct Controller {
        static let home = "HomeViewController"
        static let category = "CategoryViewController"
        static let details = "MediaDetailsViewController"
    }

    struct Cell {
        static let grid = "GridCollectionViewCell"
        static let header = "HeaderCollectionReusableView"
        static let footer = "FooterCollectionReusableView"
    }

    struct Storyboard {
        static let main = "Main"
    }
}

enum PageSize: Int{
    case Search = 30
    case Category = 50
}

let isSafeSearchEnabled = true
