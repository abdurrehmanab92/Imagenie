//
//  CategoryRouter.swift
//  Imagenie
//
//  Created by Abdur Rehman on 30/06/2021.
//

import UIKit

@objc protocol CategoryRoutingLogic{
    func navigateToDetailsView(item withIndex: Int)
}

protocol CategoryDataPassing{
    var dataStore: CategoryDataStore? { get set}
}

class CategoryRouter: NSObject, CategoryRoutingLogic, CategoryDataPassing{
    weak var viewController: CategoryViewController?
    var dataStore: CategoryDataStore?

    func navigateToDetailsView(item withIndex: Int) {
        let destVC = UIStoryboard(name: Identifier.Storyboard.main, bundle: nil).instantiateViewController(identifier: Identifier.Controller.details) as! MediaDetailsViewController

        destVC.media = dataStore?.categoryItems[withIndex]

        if dataStore!.isSearchControllerActive{
            viewController?.present(destVC, animated: true)
        }else{
            viewController?.navigationController?.pushViewController(destVC, animated: true)
        }
    }
}
