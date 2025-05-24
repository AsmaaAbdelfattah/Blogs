//
//  NetworkManager.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import Foundation
import UIKit
import Alamofire
protocol NetworkServiceProtocol {
    func getData(url: String,completionHandler: @escaping (Result<[Blog], Error>) -> Void)
    func getBlog(url: String,completionHandler: @escaping (Result<Blog, Error>) -> Void)
    func addBlog(url:String,parameters:[String:String],photo:UIImage?,completionHandler: @escaping (Result<Blog, Error>) -> Void)
    func deleteBlog(url:String,completionHandler: @escaping (Result<DeleteResponse, Error>) -> Void)
}

class NetworkService:NetworkServiceProtocol{
   
    private static var networkService : NetworkService?
    public static func getInstance()->NetworkService{
        if networkService == nil {
            networkService = NetworkService()
        }
        return networkService!
    }
    
    func getData(url: String, completionHandler: @escaping (Result<[Blog], Error>) -> Void){
        let request = AF.request(url, method: .get )
        request.responseDecodable(of: [Blog].self) { response in
            switch response.result {
            case .success(let items):
                completionHandler(.success(items))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }

        }
    func getBlog(url: String, completionHandler: @escaping (Result<Blog, any Error>) -> Void) {
        let request = AF.request(url , method: .get )
        request.responseDecodable(of:Blog.self) { (response) in
            switch response.result {
            case .success(let items):
                completionHandler(.success(items))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }

    }
    func addBlog(url:String,parameters:[String:String],photo:UIImage?,completionHandler: @escaping (Result<Blog, Error>) -> Void){
        AF.upload(multipartFormData: { multipartFormData in
               
               // Append image if available
               if let image = photo, let imageData = image.jpegData(compressionQuality: 0.8) {
                   multipartFormData.append(imageData, withName: "photo", fileName: "image.jpg", mimeType: "image/jpeg")
               }
               
               // Append other parameters
               for (key, value) in parameters {
                   multipartFormData.append(Data(value.utf8), withName: key)
               }
               
           }, to: url)
           .responseData { response in
               switch response.result {
               case .success(let data):
                   do {
                       let blog = try JSONDecoder().decode(Blog.self, from: data)
                       completionHandler(.success(blog))
                   } catch {
                       completionHandler(.failure(error))
                   }
               case .failure(let error):
                   completionHandler(.failure(error))
               }
           }
       }
    
    func deleteBlog(url:String,completionHandler: @escaping (Result<DeleteResponse, Error>) -> Void){
        AF.request(url, method: .post , encoding:  URLEncoding.default).responseDecodable(of:  DeleteResponse.self){ response in
            switch response.result{
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
}

