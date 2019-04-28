//
//  APIService.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 20/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    
    // Fetch Searched Apps
    func fetchItuneApps(searchText : String, completion : @escaping (SearchResultApps?,Error?)->()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchAppDetail(appId : String, completion : @escaping (SearchResultApps?,Error?)->()) {
        let jsonUrl = "https://itunes.apple.com/lookup?id=\(appId)"
        fetchGenericJSONData(urlString: jsonUrl, completion: completion)
    }
    
    func fetchAppReviews(appId : String, completion : @escaping (AppReview?,Error?)->()) {
        let jsonUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        fetchGenericJSONData(urlString: jsonUrl, completion: completion)
    }
    
    // Top Grossing
    func fetchTopGrossing(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // Fetch Games
    func fetchGames(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // Top Free
    func fetchTopFree(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    // Social Apps
    func fetchSocialApps(completion : @escaping ([SocialApp]?,Error?)->()) {
        let jsonUrl = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: jsonUrl, completion: completion)
    }
    
    
    // Generic Fetch function
    
    func fetchGenericJSONData<T : Decodable>(urlString : String, completion : @escaping (T?, Error?)->()) {
        
        guard let url = URL(string: urlString) else { return  }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch Social Apps.", error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                completion(jsonData,nil)
            }
            catch let err {
                print("Failed to decode Json: \(err)")
                completion(nil,err)
            }
        }.resume()
        
    }
    
    
}
