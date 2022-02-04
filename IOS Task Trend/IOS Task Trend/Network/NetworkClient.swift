//
//  NetworkClient.swift
//  IOS Task Trend
//
//  Created by Apple on 2/4/22.
//

import Foundation
import Combine
import Alamofire
class NetworkClient {
    static let shared = NetworkClient()
    private init(){}
    func createRequest<T:Decodable>(router:APIRouter,with decoded:T.Type,withBase:Bool = true ,parameters:[String:Any]?=nil,returnWithData:@escaping(T?)->(),returnError:@escaping(Error?)->())
        {

        AF.request(router)
            .validate()
            .responseJSON{ (response) in
                switch response.result{
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let responseModel = try JSONDecoder().decode(T.self, from: data)
                        returnWithData(responseModel)
                        return
                    } catch let error{
                        returnError(error)
                            return
                    }
                case  .failure(let error):
                    print("No InterNet Connetion Network Client")
                    returnError(error)
                  //  observer(.failure(AppError(message: "No internet connection")))
                }
            }.resume()

        
        }
}
