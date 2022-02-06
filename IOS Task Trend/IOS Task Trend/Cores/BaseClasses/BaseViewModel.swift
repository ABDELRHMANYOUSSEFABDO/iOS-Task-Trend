//
//  BaseViewModel.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import Foundation

class BaseViewModel {
    
    var error: APIError?
    var errormessage: String?

    var updateLoadingStatus: (()->())?
    var didShowMessage:((String)->())?
    // callback for interfaces
    var loadingState: State = .populated {
        didSet {
            self.updateLoadingStatus?()
        }
    }
        
    func getError() -> APIError? {
        return self.error
    }
}
