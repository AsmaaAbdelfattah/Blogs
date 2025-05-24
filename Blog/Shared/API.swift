//
//  API.swift
//  Weather
//
//  Created by asma abdelfattah on 15/05/2025.
//

import Foundation
enum Networking{
    private var baseURL: String { return  UserDefaults.standard.getBase()}
    
  case  blogs
    case blogDetails(id:Int)
    case addBlog
    case editBlog(id:Int)
    case deleteBlog(id:Int)
}
extension Networking{

    var fullPath :String {
        var endPoint: String
        switch self {
        case .blogs:
            endPoint = "api/blogs"
        case .blogDetails(let id):
            endPoint = "api/blogs/show/\(id)"
        case .addBlog:
            endPoint = "api/blogs/store"
        case .editBlog(let id):
            endPoint = "api/blogs/update/\(id)"
        case .deleteBlog(let id):
            endPoint = "api/blogs/delete/\(id)"
        }
        return baseURL + endPoint
    }
}
