//
//  ViewController.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import UIKit
import RxSwift
import NVActivityIndicatorView
class HomeVC: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var blogsTB: UITableView!{
        didSet{
            blogsTB.register(UINib(nibName: "BlogTBCell", bundle: nil), forCellReuseIdentifier: "BlogTBCell")
            blogsTB.dataSource = self
            blogsTB.delegate = self
            blogsTB.rowHeight = 80
        }
    }
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    @IBOutlet weak var emptyLbl: UILabel!
    //MARK: vars
    let vm = BlogViewModel()
    let bag = DisposeBag()
    //MARK: life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyLbl.isHidden = true
        getBlogs()
        handleError()
    }
    
    func getBlogs(){
        indicator.showIndicator(start: true)
        vm.getBlogs(url: Networking.blogs.fullPath)
        vm.bindBlogs = {[weak self] () in
            self?.indicator.showIndicator(start: false)
            if let _ = self?.vm.blogs {
                self?.blogsTB.isHidden = false
                self?.emptyLbl.isHidden = true
                self?.blogsTB.reloadData()
            }
        }
    }
    //MARK: handle api response
    func handleError(){
        vm.error.observe(on: MainScheduler.instance).subscribe{[weak self] error in
            guard let message = error.element else {return }
            self?.indicator.showIndicator(start: false)
            self?.createAlert(title: "", message: message)
        }.disposed(by: bag)
        vm.empty.observe(on: MainScheduler.instance).subscribe{[weak self] error in
            guard let hide = error.element else {return }
            self?.indicator.showIndicator(start: false)
            self?.emptyLbl.isHidden = !hide
            self?.blogsTB.isHidden = hide
        }.disposed(by: bag)
        vm.refresh.observe(on: MainScheduler.instance).subscribe{[weak self] error in
            guard error.element != nil else {return }
            self?.indicator.showIndicator(start: false)
            self?.getBlogs()
        }.disposed(by: bag)
    }

    //MARK: Actions
    @IBAction func addTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "BlogDetails", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "blog") as? BlogDetailsVC{
            vc.modalPresentationStyle = .pageSheet
            vc.finishAddBlog = {[weak self] () in
                self?.getBlogs()
            }
      if #available(iOS 15.0, *) {
          if let sheet = vc.sheetPresentationController {
              sheet.detents = [.medium(), .large()] // Define popover sizes
              sheet.prefersGrabberVisible = true // Show a grabber for dragging
              sheet.prefersEdgeAttachedInCompactHeight = true // Attach to top in compact height
          }
      } else {
          // Fallback on earlier versions
          navigationController?.pushViewController(vc, animated: true)
      }
      self.present(vc, animated: true, completion: nil)
        }
    }
}

extension HomeVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.blogs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTBCell", for: indexPath) as? BlogTBCell else { return UITableViewCell()}
        if let item = vm.blogs?[indexPath.row]{
            cell.injectCell(item: item)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = vm.blogs?[indexPath.row]{
            let storyboard = UIStoryboard(name: "BlogDetails", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "blog") as? BlogDetailsVC {
                vc.id = item.id
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let item = vm.blogs?[indexPath.row]{
            indicator.showIndicator(start: true)
            vm.deleteBlog(url: Networking.deleteBlog(id: item.id).fullPath)
        }
        
   }
    
}
