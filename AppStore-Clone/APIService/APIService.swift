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
    
}
