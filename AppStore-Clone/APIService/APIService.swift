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
    
    
    //MARK: Fetch Searched Apps
    func fetchItuneApps(searchText : String, completion : @escaping ([SearchResultApp],Error?)->()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        
        guard let url = URL(string: urlString) else { return }
        
        print("URL : \(url)")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Failed to fetch result : \(err.localizedDescription)")
                completion([],err)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let searchResults = try decoder.decode(SearchResultApps.self, from: data)
                completion(searchResults.results,nil)
            }
            catch let err {
                print("Failed to decode Json: \(err)")
                completion([],err)
            }
            }.resume()
    }
    
    // Top Grossing
    func fetchTopGrossing(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // Fetch Games
    func fetchGames(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // Top Free
    func fetchTopFree(completion : @escaping (AppGroup?, Error?)->()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString : String, completion : @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to App Groups.", error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(jsonData,nil)
            }
            catch let err {
                print("Failed to decode Json: \(err)")
                completion(nil,err)
            }
            
            }.resume()
    }
    
    
    func fetchSocialApps(completion : @escaping ([SocialApp]?,Error?)->()) {
        let jsonUrl = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: jsonUrl) else { return  }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch Social Apps.", error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode([SocialApp].self, from: data)
                completion(jsonData,nil)
            }
            catch let err {
                print("Failed to decode Json: \(err)")
                completion(nil,err)
            }
        }.resume()
    }
    
    
    
    
}
