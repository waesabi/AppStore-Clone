//
//  SearchResultApp.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 20/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

struct SearchResultApps : Decodable {
    let resultCount : Int
    let results : [SearchResultApp]
}

struct SearchResultApp : Decodable {
    let trackName : String
    let primaryGenreName : String
    let averageUserRating : Float?
    let artworkUrl100 : String // App Icon
    let screenshotUrls : [String] // Screenshot
}


