//
//  BlogViewModel.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation


class BlogViewModel {
    var data = Observable<[Blog]> (value : [])
    let container : Container
    var pageCounter = 1
    
    init(_ container:Container) {
        self.container = container
    }
    
    func getBlogsData() {
        APIClient.getBlogs(for: pageCounter) { (result) in
            switch result{
            case .success(let response):
                self.writeToCD(response)
                self.pageCounter += 1
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func writeToCD(_ blogModels:[BlogModel]) {
        var tempArray = data.value
        for blogModel in blogModels{
            let predicate = NSPredicate(format: "id == %@", blogModel.id)
            var blog : Blog?
            if let tempBlogs = self.container.fetchData(of: Blog.self, with: predicate){
                if tempBlogs.count > 0{
                    blog = (tempBlogs[0] as! Blog)
                    blog = blogModel.managedObject(blog!)
                }else{
                    blog = blogModel.managedObject()
                }
            }else{
                blog = blogModel.managedObject()
            }
            tempArray.append(blog!)
        }
        self.container.save()
        data.value = tempArray
        
    }
    
    func fetchBlogsData() {
        if let result = self.container.fetchData(of: Blog.self, with: nil) as? [Blog]{
            data.value = result
        }
    }
}
