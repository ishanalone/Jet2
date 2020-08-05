//
//  UserModel.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import CoreData



struct UserModel : Codable{
    let id : String
    let blogId : String
    let createdAt : String
    let name : String
    let avatar : String
    let lastname : String
    let city : String
    let designation : String
    let about : String
}

extension UserModel : Persistable{
    
    typealias ManagedObject = User
    
    public func managedObject() -> User? {
        if let context = self.context(){
            if let entity = entity(){
                let user : User = NSManagedObject(entity: entity, insertInto: context) as! User
                user.id = id
                user.blogId = blogId
                user.createdAt = createdAt
                user.name = name
                user.avatar = avatar
                user.lastname = lastname
                user.city = city
                user.designation = designation
                user.about = about
                return user
            }
            
        }
        return nil
    }
    
    func managedObject(_ object: User) -> User {
        object.id = id
        object.blogId = blogId
        object.createdAt = createdAt
        object.name = name
        object.avatar = avatar
        object.lastname = lastname
        object.city = city
        object.designation = designation
        object.about = about
        return object
    }
    
    
    
    
    public init(managedObject: User) {
        id = managedObject.id!
        blogId = managedObject.blogId!
        createdAt = managedObject.createdAt!
        name = managedObject.name!
        avatar = managedObject.avatar!
        lastname = managedObject.lastname!
        city = managedObject.city!
        designation = managedObject.designation!
        about = managedObject.about!
    }
    
    
}

extension UserModel{
    func avatarUrl() -> URL? {
        return URL(string: self.avatar)
    }
    
    func fullName() -> String {
        return self.name + " " + self.lastname
    }
}
