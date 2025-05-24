//
//  Blog.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import Foundation
import UIKit
struct Blog:Decodable{
    var id: Int
    var title: String
    var content: String
    var photo: String
    var created_at: String
    var updated_at: String
    
  
}
struct BlogBody:Codable {
    var title: String
    var content: String
}
struct DeleteResponse:Codable{
    var message:String
}
