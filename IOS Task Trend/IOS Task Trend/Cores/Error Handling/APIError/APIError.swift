//
//  APIError.swift
//
 // IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation

class APIError: NSObject {
    
    private var privateMessage: String? = "Something went wrong. Please try again."

    var message : String? {
        set {
            if let msg: String = newValue, msg.count > 0 {
                privateMessage = msg
            }
        }
        get {
            return privateMessage
        }
    }
    var extraDescription : String?
    var responseStatusCode : Int?
    var response : Any?
    var error : Error?
}
