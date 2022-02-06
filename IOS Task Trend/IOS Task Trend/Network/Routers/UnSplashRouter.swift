//
//  UnSplashRouter.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import Foundation
import Alamofire
enum UnSplash:APIRouter{
   
    
    case homeImages
    case searchImages(query:String)
    //MARK:HTTPMethods:
    var method: HTTPMethod{
        switch self{
        case .homeImages,.searchImages:
        return .get
        }
    }
    
    //MARK:Path:
    var path: String {
        switch self{
        case .homeImages:
            return "photos"
            
        case .searchImages:
            return "search/photos"
        }
     
        
    }
    
    //MARK:Parameters:
    var parameters: Parameters?{
        switch self {
        case  .homeImages:
            return ["client_id":"1d18Uk1t7HtUvnUoRBHMXgIN_YO60XepjRfTdeyJbt4"
                    
            ]
            
        case let .searchImages(query:query):
            return ["query":query,
                    "client_id":"1d18Uk1t7HtUvnUoRBHMXgIN_YO60XepjRfTdeyJbt4"
            ]
        }
    }
    
    //MARK:Encoding:
    var encoding: ParameterEncoding{
        switch self{
        case .homeImages,.searchImages:
            return URLEncoding.queryString
        }
    }
    
}
