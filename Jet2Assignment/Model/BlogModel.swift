//
//  BlogModel.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct BlogModel : Codable {
    let id : String
    let createdAt : String
    let content : String
    let comments : Int
    let likes : Int
    var media : [MediaModel]
    let user : [UserModel]
    var contentHeight : CGFloat?
}

extension BlogModel : Persistable{
    typealias ManagedObject = Blog
    
    init(managedObject: Blog) {
        id = managedObject.id!
        createdAt = managedObject.createdAt!
        content = managedObject.content!
        comments = Int(managedObject.comments)
        likes = Int(managedObject.likes)
        var tempMediaArr : [MediaModel] = []
        for item in Array(managedObject.media!){
            let mediaItem = MediaModel(managedObject: item as! Media)
            tempMediaArr.append(mediaItem)
        }
        media = tempMediaArr
        
        var tempUserArr : [UserModel] = []
        for item in Array(managedObject.user!){
            let userItem = UserModel(managedObject: item as! User)
            tempUserArr.append(userItem)
        }
        user = tempUserArr
    }
    
    func managedObject() -> Blog? {
        if let context = self.context(){
            if let entity = entity(){
                let blog : Blog = NSManagedObject(entity: entity, insertInto: context) as! Blog
                blog.id = id
                blog.createdAt = createdAt
                blog.content = content
                blog.comments = Int32(comments)
                blog.likes = Int32(likes)
                var tempMediaArr : [Media] = []
                for item in media{
                    let mediaItem = item.managedObject()!
                    tempMediaArr.append(mediaItem)
                }
                blog.media = NSSet(array: tempMediaArr)
                
                var tempUserArr : [User] = []
                for item in user{
                    let userItem = item.managedObject()!
                    tempUserArr.append(userItem)
                }
                blog.user = NSSet(array: tempUserArr)
                return blog
            }
            
        }
        return nil
    }
    
    func managedObject(_ object: Blog) -> Blog {
        object.id = id
        object.createdAt = createdAt
        object.content = content
        object.comments = Int32(comments)
        object.likes = Int32(likes)
        var tempMediaArr : [Media] = []
        let mediaArr = Array(object.media!)
        for (index,item) in media.enumerated(){
            let mediaObject = mediaArr[index]
            let mediaItem = item.managedObject(mediaObject as! Media)
            tempMediaArr.append(mediaItem)
        }
        object.media = NSSet(array: tempMediaArr)
        
        var tempUserArr : [User] = []
        let userArr = Array(object.user!)
        for (index,item) in user.enumerated(){
            let userObject = userArr[index]
            let userItem = item.managedObject(userObject as! User)
            tempUserArr.append(userItem)
        }
        
        object.user = NSSet(array: tempUserArr)
        return object
    }

}

// For formatted data
extension BlogModel {
    
    func commentsString() -> String {
        let comments : Double = Double(self.comments)
        let formattedStr = getFormattedString(for: comments)
        return formattedStr + " Comments"
    }
    
    func getLikesString() -> String {
        let likes : Double = Double(self.likes)
        let formattedStr = getFormattedString(for: likes)
        return formattedStr + " Likes"
    }
    
    func getCreatedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdDate = dateFormatter.date(from: createdAt)
        return createdDate!.timeAgoSinceDate()
    }
    
    func getFormattedString(for value:Double) -> String {
        var formattedStr = ""
        var fomattedValue = value
        var unit = ""
        if comments > 1000{
            unit = "K"
            fomattedValue = Double(comments)/Double(1000)
        }else if comments > 1000000{
            unit = "M"
            fomattedValue = Double(comments/1000000)
        }
        formattedStr = getRemainderString(fomattedValue)
        
        return formattedStr+unit
    }
    
    func getRemainderString(_ value : Double) -> String {
        var commentStr = ""
        let remainder = value.truncatingRemainder(dividingBy: 1)
        if remainder >= 0.1 && remainder <= 0.99{
            commentStr = String(format: "%.1f", value)
        }else{
            commentStr = String(format: "%.0f", value)
        }
        return commentStr
    }
    
    mutating func setHeight(for width:CGFloat){
        var height = self.content.heightWithConstrainedWidth(width: width, font: BaseConstants.contentFont)
        if height > 100{
            height = 100
        }
        self.contentHeight = height
    }
    
}


