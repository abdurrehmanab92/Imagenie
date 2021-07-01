//
//  Picture.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import Foundation

struct Media:Codable{
    let collections : Int?
    let comments : Int?
    let downloads : Int?
    let favorites : Int?
    let id : Int?
    let imageHeight : Int?
    let imageSize : Int?
    let imageWidth : Int?
    let largeImageURL : String?
    let likes : Int?
    let pageURL : String?
    let previewHeight : Int?
    let previewURL : String?
    let previewWidth : Int?
    let tags : String?
    let type : String?
    let user : String?
    let userId : Int?
    let userImageURL : String?
    let views : Int?
    let webformatHeight : Int?
    let webformatURL : String?
    let webformatWidth : Int?

    enum CodingKeys: String, CodingKey {
        case collections, comments, downloads, favorites, id, imageHeight, imageSize, imageWidth, largeImageURL, likes, pageURL, previewHeight, previewURL, previewWidth, tags, type, user, userId, userImageURL, views, webformatHeight, webformatURL, webformatWidth
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collections = try values.decodeIfPresent(Int.self, forKey: .collections)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        downloads = try values.decodeIfPresent(Int.self, forKey: .downloads)
        favorites = try values.decodeIfPresent(Int.self, forKey: .favorites)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageHeight = try values.decodeIfPresent(Int.self, forKey: .imageHeight)
        imageSize = try values.decodeIfPresent(Int.self, forKey: .imageSize)
        imageWidth = try values.decodeIfPresent(Int.self, forKey: .imageWidth)
        largeImageURL = try values.decodeIfPresent(String.self, forKey: .largeImageURL)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        pageURL = try values.decodeIfPresent(String.self, forKey: .pageURL)
        previewHeight = try values.decodeIfPresent(Int.self, forKey: .previewHeight)
        previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
        previewWidth = try values.decodeIfPresent(Int.self, forKey: .previewWidth)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        userImageURL = try values.decodeIfPresent(String.self, forKey: .userImageURL)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        webformatHeight = try values.decodeIfPresent(Int.self, forKey: .webformatHeight)
        webformatURL = try values.decodeIfPresent(String.self, forKey: .webformatURL)
        webformatWidth = try values.decodeIfPresent(Int.self, forKey: .webformatWidth)
    }
}

extension Media:Hashable,Equatable{}
