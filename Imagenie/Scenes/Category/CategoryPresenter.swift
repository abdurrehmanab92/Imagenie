//
//  CategoryPresenter.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

protocol CategoryPresentationLogic{
    func presentCategoryItems(response: Category.Item.Response)
}

class CategoryPresenter: CategoryPresentationLogic{
    weak var viewController: CategoryDisplayLogic?

    func presentCategoryItems(response: Category.Item.Response) {
        viewController?.displayCategoryItems(viewModel: Category.Item.ViewModel(data: response.result))
    }
}
