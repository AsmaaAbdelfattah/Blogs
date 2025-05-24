//
//  CustomTextField.swift
//  Blog
//
//  Created by asmaa abdelfattah on 29/10/2024.
//

import UIKit
class PaddedTextField: UITextField {
    
    var padding: UIEdgeInsets

    // Initialize with padding
    override init(frame: CGRect) {
        self.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        super.init(coder: aDecoder)
    }

    // Adjust textRect to include padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // Adjust placeholderRect to include padding
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
