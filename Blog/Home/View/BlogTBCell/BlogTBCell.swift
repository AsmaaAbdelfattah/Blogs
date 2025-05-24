//
//  BlogTBCell.swift
//  Blog
//
//  Created by asma abdelfattah on 24/05/2025.
//

import UIKit

class BlogTBCell: UITableViewCell {

    @IBOutlet weak var blogView: UIView!{
        didSet{
            blogView.dropShadow()
        }
    }
    @IBOutlet weak var blogImg: UIImageView!{
        didSet{
            blogImg.layer.cornerRadius = blogImg.frame.height / 2
        }
    }
    @IBOutlet weak var blogTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func injectCell(item: Blog){
        blogTitle.text = item.title
        blogImg.setImagePlaceHolder(img:  item.photo)
    }
}
