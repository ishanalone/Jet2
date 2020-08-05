//
//  BlogCell.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

class BlogCell: BaseCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    init(_ reuseIdentifier:String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    func updateUI(with data:BlogModel) {
        self.blogModel = data
        if let blogModel = self.blogModel{
            self.contentLbl.text = blogModel.content
            self.reinstallContentLabel()
            self.commentLbl.text = blogModel.commentsString()
            self.likesLbl.text = blogModel.getLikesString()
            self.timeLabel.text = blogModel.getCreatedDate()
            
            if blogModel.media.count > 0{
                let mediaModel = blogModel.media[0]
                if let url = mediaModel.imageUrl(){
                    self.fetchBlogImage(from: url)
                }
                self.titleLbl.text = mediaModel.title
                self.urlLbl.text = mediaModel.url
                
            }
            self.reinstallMediaImage(blogModel.media.count > 0)
            self.reinstallTitleLbl(blogModel.media.count > 0)
            self.reinstallUrlLbl(blogModel.media.count > 0)
            if blogModel.user.count > 0{
                let userModel = blogModel.user[0]
                if let url = userModel.avatarUrl(){
                    self.fetchUserImage(from: url)
                }
                self.userNameLbl.text = userModel.fullName()
                self.designationLbl.text = userModel.designation
                
            }
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
