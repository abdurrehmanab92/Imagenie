//
//  HomeModels.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import UIKit

enum Home{
  enum Item{
    struct Request{
        let type: HomeSection
    }
    struct Response{
        let type: HomeSection
        let result: [HomeItem]
    }
    struct ViewModel{
        let type: HomeSection
        let data: [HomeItem]
    }
  }
}

typealias HomeItem = Media

enum HomeSection:Int, CaseIterable{
    case EdChoice = 0, nature, science, places, animals, food, sports, travel, music
}

let HomeSectionHeader:[HomeSection:String] = [
    .EdChoice:"Editor's Choice",
    .nature: "Nature",
    .science: "Science",
    .places: "Places",
    .animals: "Animals",
    .food: "Food",
    .sports: "Sports",
    .travel: "Travel",
    .music: "Music"
]
