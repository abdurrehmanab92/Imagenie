//
//  HomeRouter.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import UIKit

protocol HomeRoutingLogic{
    func navigateToCategoryView(forCategory category: String)
    func navigateToDetailsView(forCategory category: HomeSection, itemAt index: Int)
}

protocol HomeDataPassing{
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing{
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    func navigateToCategoryView(forCategory category: String) {
        let destVC = UIStoryboard(name: Identifier.Storyboard.main, bundle: nil).instantiateViewController(identifier: Identifier.Controller.category) as! CategoryViewController

        destVC.router?.dataStore?.category = category
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }

    func navigateToDetailsView(forCategory category: HomeSection, itemAt index: Int) {
        let destVC = UIStoryboard(name: Identifier.Storyboard.main, bundle: nil).instantiateViewController(identifier: Identifier.Controller.details) as! MediaDetailsViewController

        destVC.media = dataStore?.homeItems[category]?[index]
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
}
