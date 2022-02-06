//
//  BasedViewController.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import UIKit
import Toast_Swift
import PKHUD

public enum State {
    case loading
    case error
    case populated
}

class BaseViewController<T:BaseViewModel>: UIViewController {

    var error: APIError?
    var errorMessage: String?
    var viewModel: T!
    var coordinator: Coordinator!

//    // MARK: - View Life Cycle
//
    
//    func updateUserInterface() {
//        switch Network.reachability.status {
//        case .unreachable:
//            print("WWAN")
//        case .wwan:
//
//        print("WWAN")
//        case .wifi:
//            print("WiFi")
//        }
//
//        if Network.reachability.isReachable == false {
//
//        } else if Network.reachability.isReachable == true {
//            viewDidLoad()
//        }
//
//
//    }
    init(viewModel: T, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    @objc func statusManager(_ notification: Notification) {
     //   updateUserInterface()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavigationControllerStyle()
        
        ToastManager.shared.isQueueEnabled = true
        
        bind(viewModel: self.viewModel)
        baseBind()
    }
    
    func bind(viewModel: T){
        fatalError("Override bind function first")
    }
    func baseBind(){
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.loadingState {
                    
                case .loading:
                    self.startLoading()
                case .populated:
                    self.stopLoadingWithSuccess()
                case .error:
                    self.error = self.viewModel.getError()
                    if let error = self.error,let message = error.message {
                        self.showMessage(message: message)
                    }
                }
            }
        }
        viewModel.didShowMessage = {[weak self] message in
            guard let self = self else{
                return
            }
            self.showMessage(message: message)
        }

    }
    func showMessage(message: String) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        var style: ToastStyle = ToastStyle.init()
        style.imageSize = CGSize(width: 44, height: 44)
        self.view.makeToast(message, duration: 3.0, position: .bottom, title: nil, image: nil, style: style, completion: nil)
    }
        
    func startLoading() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        HUD.show(.progress)
    }
    
    func stopLoadingWithSuccess() {
        HUD.hide()
    }
    
    
    func showAlert(title: String, message: String?, alertActions: [UIAlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in alertActions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteConfirmationAlert(content: String, confirmAction: @escaping (UIAlertAction) -> Void) {
        let noAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default, handler: confirmAction)
        
        showAlert(title: "Delete", message: "Do you want delete \(content) ?", alertActions: [yesAction, noAction])
    }
    
}
