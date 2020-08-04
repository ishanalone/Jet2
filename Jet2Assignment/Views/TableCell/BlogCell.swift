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
    
    func updateUI(with data:Blog) {
        
        let user = Array(data.user!)[0] as! User
        self.userNameLbl.text = "\(user.name ?? "")  \(user.lastname ?? "")"
        self.designationLbl.text = user.designation
        self.contentLbl.text = data.content
        if data.media!.count > 0{
            let media = Array(data.media!)[0] as! Media
            self.titleLbl.text = media.title
            self.urlLbl.text = media.url
        }else{
            self.reinstallMediaImage()
            self.reinstallTitleLbl()
            self.reinstallUrlLbl()
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
