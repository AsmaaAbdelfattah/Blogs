//
//  BlogViewModel.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import Foundation
import RxSwift
import UIKit
protocol BlogViewModelProtocol{
    var blogs:[Blog]! {get set}
    var blogDetails:Blog! {get set}
    var bindBlogs:(()->()) {set get}
    var bindBlogDetails:(()->()) {set get}
    var error : PublishSubject<String> {set get}
    var empty: PublishSubject<Bool> {set get}
    var refresh: PublishSubject<String> {set get}
    
    func getBlogs(url:String)
    func addBlog(url:String,blog:BlogBody,image:UIImage?,isEdit:Bool)
    func getBlogDetails(url:String)
    func deleteBlog(url:String)
}
class BlogViewModel: BlogViewModelProtocol{
  
    
    let networkService = NetworkService()
    
    var blogs: [Blog]!{
        didSet{
            bindBlogs()
        }
    }
    var blogDetails: Blog!{
        didSet{
            bindBlogDetails()
        }
    }
    var bindBlogs:(()->()) = {}
    var bindBlogDetails:(()->()) = {}
    var error = PublishSubject<String>()
    var empty = PublishSubject<Bool>()
    var refresh = PublishSubject<String>()
    
    func getBlogs(url:String){
        networkService.getData(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                if success.count > 0 {
                    self?.blogs = success
                }else{
                    self?.empty.onNext(true)
                }
            case .failure(let failure):
                self?.error.onNext(failure.localizedDescription)
            }
        }
    }
    func getBlogDetails(url:String){
        networkService.getBlog(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                self?.blogDetails = success
            case .failure(let failure):
                self?.error.onNext(failure.localizedDescription)
            }
        }
    }
    func addBlog(url:String,blog:BlogBody,image:UIImage?,isEdit:Bool){
        let body = ["title":blog.title,
                    "content":blog.content
                    
                ]
        networkService.addBlog(url: url, parameters: body,photo: image) { [weak self] result in
            switch result {
            case .success(let success):
                if isEdit{
                    self?.blogDetails = success
                }else{
                    self?.empty.onNext(true)
                }
            case .failure(let failure):
                self?.error.onNext(failure.localizedDescription)
            }
        }
    }
    func deleteBlog(url:String){
        networkService.deleteBlog(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                if success.message == "Deleted successfully"{
                    self?.refresh.onNext(success.message)
                }else{
                    print(success)
                    self?.error.onNext(success.message)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.error.onNext(failure.localizedDescription)
            }
        }
    }
}
