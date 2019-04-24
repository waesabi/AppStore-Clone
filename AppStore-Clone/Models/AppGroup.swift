//
//  AppGroup.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 24/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

struct AppGroup : Decodable{
    let feed : Feed
}

struct Feed : Decodable {
    let title : String
    let results : [FeedResult]
}

struct FeedResult : Decodable {
    let name : String
    let artistName : String
    let artworkUrl100 : String
}
