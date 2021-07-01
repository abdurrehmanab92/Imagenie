//
//  CategoryModels.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

enum Category{
    enum Item{
        struct Request{
            var q:String?=nil
        }
        struct Response{
            var result: [CategoryItem]
        }
        struct ViewModel{
            var data: [CategoryItem]
        }
    }
}

typealias CategoryItem = Media
