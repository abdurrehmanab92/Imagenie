//
//  ApiManager.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import SwiftyJSON
class ApiCallsManager:BaseURLSession{
    static let shared = ApiCallsManager()
    
    func fetchMedia(forCategory category:String, _ isEdChoice:Bool, completion:@escaping ([Media]?,Error?)->Void){
        get(Urls.getMediaForHomeURL(category, isEdChoice)) { (data, error) in
            do{
                let json = JSON(data!)
                let files = try JSONDecoder().decode([Media].self, from:json["hits"].rawData())
                DispatchQueue.main.async {
                    completion(files,nil)
                }
            }catch{
                completion(nil,error)
            }
        }
    }

    func fetchMedia(forCategory category:String, completion:@escaping ([Media]?,Error?)->Void){
        get(Urls.getMediaByCategoryURL(category)) { (data, error) in
            do{
                let json = JSON(data!)
                let files = try JSONDecoder().decode([Media].self, from:json["hits"].rawData())
                DispatchQueue.main.async {
                    completion(files,nil)
                }            }catch{
                completion(nil,error)
            }
        }
    }

    func fetchMedia(withQuery q:String, completion:@escaping ([Media]?,Error?)->Void){
        get(Urls.getSearchMediaURL(q)) { (data, error) in
            do{
                let json = JSON(data!)
                let files = try JSONDecoder().decode([Media].self, from:json["hits"].rawData())
                DispatchQueue.main.async {
                    completion(files,nil)
                }
            }catch{
                completion(nil,error)
            }
        }
    }
}
