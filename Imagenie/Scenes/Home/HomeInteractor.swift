//
//  HomeInteractor.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import UIKit

protocol HomeBusinessLogic{
    func fetchHomeItems(request: Home.Item.Request)
}

protocol HomeDataStore{
    var homeItems: [HomeSection:[HomeItem]] { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore{
    var homeItems: [HomeSection : [HomeItem]] = [:]
    var presenter: HomePresentationLogic?

    func fetchHomeItems(request: Home.Item.Request) {
        let category = request.type == .EdChoice ? "" : (HomeSectionHeader[request.type]!.lowercased())

        let isEdChoice = request.type == .EdChoice ? true : false

        ApiCallsManager.shared.fetchMedia(forCategory: category, isEdChoice) { [weak self] (media, error) in
            guard let media = media else {return}
            self?.homeItems[request.type] = media
            self?.presenter?.presentHomeItems(response: Home.Item.Response(type: request.type, result: media))
        }
    }
}
