//
//  BaseCell.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit

class BaseCell: UITableViewCell {

    var blog  : Blog?
    
    var container : UIView = UIView(frame: .zero)
    
    var userView : UIView = UIView(frame: .zero)
    var userImage : UIImageView = UIImageView(frame: .zero)
    var userNameLbl : UILabel = UILabel(frame: .zero)
    var designationLbl : UILabel = UILabel(frame: .zero)
    
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
        installUserName()
        installDesignation()
        installMediaImage()
        installContentLabel()
        installTitleLbl()
        installUrlLbl()
        installLikesLbl()
        installCommentsLbl()
    }
    
    func installContainer() {
        contentView.addSubview(container)
        container.backgroundColor = .white
        container.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func installUserView() {
        container.addSubview(userView)
        userView.backgroundColor = .clear
        userView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func installUserImage() {
        userView.addSubview(userImage)
        userImage.clipsToBounds = true
        userImage.snp.makeConstraints { (make) in
            make.leading.equalTo(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    func installUserName() {
        userView.addSubview(userNameLbl)
        userNameLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(userImage.snp.trailing).offset(20)
            make.top.equalTo(userImage.snp.top)
            make.height.equalTo(25)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func installDesignation() {
        userView.addSubview(designationLbl)
        designationLbl.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLbl.snp.bottom).offset(3)
            make.leading.equalTo(userNameLbl.snp.leading)
            make.trailing.equalTo(userNameLbl.snp.trailing)
            make.height.equalTo(21)
            
        }
    }
    
    func installMediaImage() {
        container.addSubview(mediaImage)
        mediaImage.addBorder(withBorderColor: .black, isTransparent: false)
        mediaImage.contentMode = .scaleAspectFit
        mediaImage.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(128)
        }
    }
    
    func reinstallMediaImage() {
        mediaImage.snp.remakeConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func installContentLabel()  {
        container.addSubview(contentLbl)
        contentLbl.numberOfLines = 0
        contentLbl.textAlignment = .left
        contentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(mediaImage.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(50)
        }
    }
    
    func installTitleLbl()  {
        container.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(contentLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(21)
        }
    }
    
    func reinstallTitleLbl() {
        titleLbl.snp.remakeConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func installUrlLbl()  {
        container.addSubview(urlLbl)
        urlLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(21)
        }
    }
    
    func reinstallUrlLbl() {
        urlLbl.snp.remakeConstraints { (make) in
            make.height.equalTo(0)
        }
    }
    
    func installLikesLbl() {
        container.addSubview(likesLbl)
        likesLbl.snp.makeConstraints { (make) in
            make.top.equalTo(urlLbl.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(0)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(30)
        }
    }
    
    func installCommentsLbl() {
        container.addSubview(commentLbl)
        commentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(urlLbl.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(0)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(30)
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
