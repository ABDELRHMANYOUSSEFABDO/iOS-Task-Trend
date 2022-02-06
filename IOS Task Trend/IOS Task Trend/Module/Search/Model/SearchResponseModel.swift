//
//  SearchResponseModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation
struct SearchResponseModel : Codable {
    let total_pages : Int?
    let results :[ImageElement]
 }
