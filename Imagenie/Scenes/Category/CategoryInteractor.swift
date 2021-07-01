//
//  CategoryInteractor.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

protocol CategoryBusinessLogic{
    func fetchCategoryItems(request: Category.Item.Request)
    func fetchSearchItems(request: Category.Item.Request)
}

protocol CategoryDataStore{
    var category: String { get set }
    var categoryItems: [CategoryItem] {get set}
    var isSearchControllerActive: Bool {get set}
}

class CategoryInteractor: CategoryBusinessLogic, CategoryDataStore{
    var isSearchControllerActive: Bool = false
    var categoryItems: [CategoryItem] = []
    var presenter: CategoryPresentationLogic?
    var category: String = ""
    var searchTask: DispatchWorkItem?

    func fetchCategoryItems(request: Category.Item.Request) {
        ApiCallsManager.shared.fetchMedia(forCategory: category.lowercased()) { [weak self] (media, error) in
            guard error == nil, let media = media else {return}
            self?.categoryItems = media
            self?.presenter?.presentCategoryItems(response: Category.Item.Response(result: media))
        }
    }

    func fetchSearchItems(request: Category.Item.Request){
        searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            ApiCallsManager.shared.fetchMedia(withQuery: request.q ?? "") { [weak self] (media, error) in
                guard error == nil, let media = media else {return}
                self?.categoryItems = media
                self?.presenter?.presentCategoryItems(response: Category.Item.Response(result: media))
            }
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
}
