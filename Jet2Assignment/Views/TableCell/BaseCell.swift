//
//  BaseCell.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

struct BaseConstants{
    static let userImageHeight : CGFloat = 50.0
    static let userViewHeight : CGFloat = 60.0
    static let marginOffset  = 5
    static let userPlaceholder = UIImage(named: "defaultUser")
    static let mediaImageHeight = 128
    static let contentFont = UIFont.systemFont(ofSize: 18)
}


class BaseCell: UITableViewCell {

    var blogModel  : BlogModel?
    
    var container : UIView = UIView(frame: .zero)
    
    var userView : UIView = UIView(frame: .zero)
    var userImage : UIImageView = UIImageView(frame: .zero)
    var userNameLbl : UILabel = UILabel(frame: .zero)
    var designationLbl : UILabel = UILabel(frame: .zero)
    var timeLabel : UILabel = UILabel(frame: .zero)
    
    var mediaImage : UIImageView = UIImageView(frame: .zero)
    var contentLbl : UILabel = UILabel(frame: .zero)
    var titleLbl : UILabel = UILabel(frame: .zero)
    var urlLbl : UILabel = UILabel(frame: .zero)
    
    var commentLbl : UILabel = UILabel(frame: .zero)
    var likesLbl : UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        installContainer()
        installUserView()
        installUserImage()
        installDateLabel()
        installUserName()
        installDesignation()
        installMediaImage()
        installContentLabel()
        installTitleLbl()
        installUrlLbl()
        installLikesLbl()
        installCommentsLbl()
        self.selectionStyle = .none
    }
    
    func installContainer() {
        contentView.addSubview(container)
        container.backgroundColor = .white
        container.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.bottom.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
        }
    }
    
    func installUserView() {
        container.addSubview(userView)
        userView.backgroundColor = .clear
        userView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(BaseConstants.marginOffset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(BaseConstants.userViewHeight)
        }
    }
    
    func installUserImage() {
        userView.addSubview(userImage)
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = BaseConstants.userImageHeight/2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.gray.cgColor
        userImage.snp.makeConstraints { (make) in
            make.leading.equalTo(BaseConstants.marginOffset)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(BaseConstants.userImageHeight)
        }
    }
    
    func installUserName() {
        userView.addSubview(userNameLbl)
        userNameLbl.font = UIFont.boldSystemFont(ofSize: 14)
        userNameLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.top.equalTo(userImage.snp.top)
            make.height.equalTo(21)
            make.trailing.equalTo(timeLabel.snp.leading).offset(BaseConstants.marginOffset)
        }
    }
    
    func installDesignation() {
        userView.addSubview(designationLbl)
        designationLbl.font = UIFont.systemFont(ofSize: 12)
        designationLbl.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLbl.snp.bottom).offset(1)
            make.leading.equalTo(userNameLbl.snp.leading)
            make.trailing.equalTo(userNameLbl.snp.trailing)
            make.height.equalTo(21)
            
        }
    }
    
    func installDateLabel() {
        userView.addSubview(timeLabel)
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(21)
        }
    }
    
    func installMediaImage() {
        container.addSubview(mediaImage)
        mediaImage.addBorder(withBorderColor: .black, isTransparent: false)
        mediaImage.contentMode = .scaleAspectFit
        mediaImage.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.height.equalTo(BaseConstants.mediaImageHeight)
        }
    }
    
    func reinstallMediaImage(_ isAvailable:Bool) {
        mediaImage.snp.remakeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            if isAvailable{
                make.height.equalTo(BaseConstants.mediaImageHeight)
            }else{
                make.height.equalTo(0)
            }
            
        }
    }
    
    func installContentLabel()  {
        container.addSubview(contentLbl)
        contentLbl.numberOfLines = 0
        contentLbl.textAlignment = .left
        contentLbl.font = BaseConstants.contentFont
        contentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(mediaImage.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.height.equalTo(0)
        }
    }
    
    func reinstallContentLabel() {
        contentLbl.snp.remakeConstraints { (make) in
            make.top.equalTo(mediaImage.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.height.equalTo(Double(blogModel!.contentHeight!))
        }
    }
    
    func installTitleLbl()  {
        container.addSubview(titleLbl)
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(contentLbl.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.height.equalTo(21)
        }
    }
    
    
    func reinstallTitleLbl(_ isAvailable:Bool) {
        titleLbl.snp.remakeConstraints { (make) in
            make.top.equalTo(contentLbl.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            if isAvailable{
                make.height.equalTo(21)
            }else{
                make.height.equalTo(0)
            }
            
        }
    }
    
    func installUrlLbl()  {
        container.addSubview(urlLbl)
        urlLbl.font = UIFont.systemFont(ofSize: 14)
        urlLbl.textColor = .blue
        urlLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.height.equalTo(21)
        }
    }
    
    func reinstallUrlLbl(_ isAvailable:Bool) {
        urlLbl.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(BaseConstants.marginOffset)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            if isAvailable{
                make.height.equalTo(21)
            }else{
                make.height.equalTo(0)
            }
            
        }
    }
    
    func installLikesLbl() {
        container.addSubview(likesLbl)
        likesLbl.font = UIFont.boldSystemFont(ofSize: 14)
        likesLbl.snp.makeConstraints { (make) in
            make.top.equalTo(urlLbl.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(BaseConstants.marginOffset)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(30)
        }
    }
    
    func installCommentsLbl() {
        container.addSubview(commentLbl)
        commentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        commentLbl.textAlignment = .right
        commentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(urlLbl.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-1*BaseConstants.marginOffset)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(30)
        }
    }
    
    func fetchUserImage(from url:URL)  {
        let processor = RoundCornerImageProcessor(cornerRadius: BaseConstants.userImageHeight)
        self.userImage.kf.setImage(with: url, placeholder : BaseConstants.userPlaceholder ,  options: [.processor(processor)])
    }
    
    func fetchBlogImage(from url:URL)  {
        self.mediaImage.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
