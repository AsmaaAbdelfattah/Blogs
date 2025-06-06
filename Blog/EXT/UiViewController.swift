//
//  UiViewController.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import Foundation
import UIKit

extension UIViewController{
    
    func createAlert(title:String,message: String){
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
