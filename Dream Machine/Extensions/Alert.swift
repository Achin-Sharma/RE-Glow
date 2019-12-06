//
//  Alert.swift
//  Dream Machine
//
//  Created by STUser on 25/11/19.
//  Copyright © 2019 Manish Katoch. All rights reserved.
//

import Foundation
import UIKit


class Alert: NSObject {
    
    typealias CompletionHandler = (() -> Swift.Void)?
    typealias CompletionHandlerResponce = ((Bool) -> ())
    
    func showTimerAlert(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandler: CompletionHandler){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        view.present(alertController, animated: true, completion: {})
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion:
                {
                    
                    completionHandler?()
                    
            })
        }
    }
    
    
    func showTimerAlertAndAction(withTitle title: String, withMessage message: String, inView view: UIViewController, completionHandlerResponce: @escaping CompletionHandlerResponce){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        view.present(alertController, animated: true, completion: {})
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion:
                {
                    completionHandlerResponce(true)
            })
        }
    }
    
   
}
