//
//  MediaModel.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import CoreData

struct MediaModel : Codable {
    let id : String
    let blogId : String
    let createdAt : String
    let image : String
    let title : String
    let url : String
}

extension MediaModel : Persistable{
    
    typealias ManagedObject = Media
    
    public func managedObject() -> Media? {
        if let context = self.context(){
            if let entity = entity(){
                let media : Media = NSManagedObject(entity: entity, insertInto: context) as! Media
                media.id = id
                media.createdAt = createdAt
                media.title = title
                media.image = image
                media.url = url
                return media
            }
            
        }
        return nil
    }
    
    func managedObject(_ object: Media) -> Media {
        object.id = id
        object.createdAt = createdAt
        object.title = title
        object.image = image
        object.url = url
        return object
    }
    
    
    
    public init(managedObject: Media) {
        id = managedObject.id!
        blogId = managedObject.blogId!
        createdAt = managedObject.createdAt!
        title = managedObject.title!
        image = managedObject.image!
        url = managedObject.url!
        
    }
    
    
}
