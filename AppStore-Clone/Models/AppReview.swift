//
//  AppReview.swift
//  AppStore-Clone
//
//  Created by sanket kumar on 28/04/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import Foundation

//https://itunes.apple.com/rss/customerreviews/page=1/id=1152350815/sortby=mostrecent/json?l=en&cc=us


struct AppReview : Decodable {
    let feed : ReviewFeed
}

struct ReviewFeed : Decodable {
    let entry : [ReviewEntry]
}

struct ReviewEntry : Decodable {
    let author : ReviewAuthor
    let title : ReviewLabel
    let content : ReviewLabel
}

struct ReviewAuthor : Decodable {
    let name : ReviewLabel
}

struct ReviewLabel : Decodable {
    let label : String
}


