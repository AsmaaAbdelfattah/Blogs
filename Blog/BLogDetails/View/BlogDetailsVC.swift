//
//  BlogDetailsVC.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import UIKit
import RxSwift
import NVActivityIndicatorView
import MobileCoreServices
class BlogDetailsVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var blogImg: UIImageView!
    @IBOutlet weak var blogTitle: PaddedTextField!{
        didSet{
            blogTitle.layer.cornerRadius = 4
            blogTitle.layer.borderWidth = 1
            blogTitle.layer.borderColor = UIColor.main.cgColor
        }
    }
    @IBOutlet weak var blogDetails: PaddedTextField!{
        didSet{
            blogDetails.layer.cornerRadius = 4
            blogDetails.layer.borderWidth = 1
            blogDetails.layer.borderColor = UIColor.main.cgColor
        }
    }
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    //MARK: vars
    let vm = BlogViewModel()
    var id:Int?
    let bag = DisposeBag()
    var blog = BlogBody(title: "", content: "")
    var photo:UIImage?
    let imageMediaType = kUTTypeImage as String
    var finishAddBlog: (()->())?
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        handleResponse()
    }
    //MARK: initialize View
    func initView(){
    
        //handle screen state
        if let id = id{
            editBtn.setTitle("Edit", for: .normal)
            indicator.showIndicator(start: true)
            vm.getBlogDetails(url: Networking.blogDetails(id: id).fullPath)
        }else{
            editBtn.setTitle("Add Blog", for: .normal)
            
        }
        //handle edit or add img
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleImg))
        blogImg.isUserInteractionEnabled = true
        blogImg.addGestureRecognizer(gesture)
    }
    //MARK: handle api response
    func handleResponse(){
        vm.error.observe(on: MainScheduler.instance).subscribe{[weak self] error in
            guard let message = error.element else {return }
            self?.indicator.showIndicator(start: false)
            self?.createAlert(title: "", message: message)
        }.disposed(by: bag)
        
        vm.bindBlogDetails = {[weak self] () in
            self?.indicator.showIndicator(start: false)
            if let blogDetails = self?.vm.blogDetails{
                self?.blog = BlogBody(title: blogDetails.title, content: blogDetails.content)
             
                    self?.blogImg.setImagePlaceHolder(img: blogDetails.photo)
                self?.blogImg.contentMode = .scaleAspectFill
                    self?.blogTitle.text = blogDetails.title
                    self?.blogDetails.text = blogDetails.content
                        
            }
            
        }
        vm.empty.observe(on: MainScheduler.instance).subscribe{[weak self] error in
            guard let _ = error.element else {return }
            self?.indicator.showIndicator(start: false)
            self?.finishAddBlog?()
            self?.dismiss(animated: true)
        }.disposed(by: bag)
    }
    //MARK: validate data for request
    func validateData(title:String,content:String)->Bool{
        if title.isEmpty{
          createAlert(title: "Attention", message: "Please add Blog Title")
            return false
        }
        if content.isEmpty{
          createAlert(title: "Attention", message: "Please add Blog Content")
            return false
        }
        if id == nil , photo == nil{
            createAlert(title: "Attention", message:  "Please add Blog Image")
            return false
        }
        return true
    }
    
    //MARK: Actions
    @IBAction func editTapped(_ sender: Any) {
        if let title = blogTitle.text ,let content = blogDetails.text {
            if validateData(title: title, content: content){
                indicator.showIndicator(start: true)
            if let id = id {
                vm.addBlog(url: Networking.editBlog(id: id).fullPath, blog: BlogBody(title:title,content: content),image: photo,isEdit: true)
            }
            else{
                vm.addBlog(url: Networking.addBlog.fullPath, blog: BlogBody(title:title,content: content),image: photo,isEdit: false)
                }
            }
        }
    }
    //MARK: open picker
    @objc func handleImg(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.mediaTypes = [imageMediaType]
        present(picker, animated: true)
    }
}

extension BlogDetailsVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true)
           if let image = info[.editedImage] as? UIImage {
               photo = image
               blogImg.image = image
               blogImg.contentMode = .scaleAspectFill
           }

       }
}
