//
//  Urls.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import Foundation

struct Urls {
    static let baseURL = "https://pixabay.com/api?key=22289613-3a85d472dca5122569ca13a42&&safesearch=\(isSafeSearchEnabled)&orientation=vertical&"
    
    static func getMediaByCategoryURL(_ category: String)->String{
        return baseURL + "category=\(category)&per_page=\(PageSize.Category.rawValue)"
    }

    static func getMediaForHomeURL(_ category: String, _ isEdChoice: Bool)->String{
        return baseURL + "category=\(category)&editors_choice=\(isEdChoice)"
    }

    static func getSearchMediaURL(_ q: String)->String{
        return baseURL + "q=\(q)&per_page=\(PageSize.Search.rawValue)"
    }
}
