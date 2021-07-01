//
//  HomePresenter.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import UIKit

protocol HomePresentationLogic{
    func presentHomeItems(response: Home.Item.Response)
}

class HomePresenter: HomePresentationLogic{
    weak var viewController: HomeDisplayLogic?

    func presentHomeItems(response: Home.Item.Response){
        let viewModel = Home.Item.ViewModel(type: response.type, data: response.result)
        viewController?.displayHomeItems(viewModel: viewModel)
    }
}
