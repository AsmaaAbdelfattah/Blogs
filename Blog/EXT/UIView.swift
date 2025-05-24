//
//  UIView.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import UIKit
extension UIView{
    func dropShadow(color:CGColor = UIColor.systemGray4.cgColor ){
        layer.cornerRadius = 5
        layer.shadowColor = color
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        clipsToBounds = false
    }
}
