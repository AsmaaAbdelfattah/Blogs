//
//  Indicator.swift
//  Blog
//
//  Created by Asmaa_Abdelfattah on 20/07/1402 AP.
//

import Foundation
import NVActivityIndicatorView
import UIKit

extension NVActivityIndicatorView{
    public func showIndicator(start:Bool){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.isHidden = !start
            if start{
                self.type = .ballBeat
                self.color = UIColor(red: 0.51, green: 0.79, blue: 1.00, alpha: 1.00)
                self.startAnimating()
            }else{
                self.stopAnimating()
            }
        }
    }
}

