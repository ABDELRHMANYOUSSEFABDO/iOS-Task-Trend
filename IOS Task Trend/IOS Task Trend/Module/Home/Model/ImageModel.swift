//
//  ImageModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation

// MARK: - ImageElement
struct ImageElement: Codable {
    let id: String?
    var urls :Urls?
   // var user :User?
    enum CodingKeys: String, CodingKey {
        case id
        case urls
       // case user
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
    let smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
    
}
struct User: Codable {
    let id: String?
    let updatedAt: Date?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
  

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location
       
      
    }
}
