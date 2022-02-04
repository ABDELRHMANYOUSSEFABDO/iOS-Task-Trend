//
//  ApiRouter.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String  { get }
    var parameters: Parameters?  { get }
    var encoding: ParameterEncoding { get }

}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        guard var url: URL = URL(string: Constant.baseUrl) else {
            throw UnSplashError.URLNotValid
        }
        url.appendPathComponent(path)
        
        let request = try URLRequest(url: url, method: method, headers: nil)
        
        return try encoding.encode(request, with: parameters)
    }
}
enum UnSplashError: Error {
    case URLNotValid
}
