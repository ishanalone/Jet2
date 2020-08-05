//
//  BlogViewModel.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 05/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import UIKit

class BlogViewModel {
    var data = Observable<[BlogModel]> (value : [])
    var isLoading = Observable<Bool> (value : false)
    var isReachable : Bool = true
    let container : Container
    var pageCounter = 1
    let tableView : UITableView
    init(_ container:Container, tableView:UITableView) {
        self.container = container
        self.tableView = tableView
        if let lastPageCounter = UserDefaults.standard.value(forKey: "LastPageFetched") as? Int{
            self.pageCounter = lastPageCounter + 1
        }
    }
    
    func getBlogsData() {
        if isReachable {
            isLoading.value = true
            APIClient.getBlogs(for: pageCounter) { (result) in
                switch result{
                case .success(let response):
                    self.writeToCD(response)
                    if response.count > 0{
                        UserDefaults.standard.set(self.pageCounter, forKey: "LastPageFetched")
                        self.pageCounter += 1
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    func writeToCD(_ blogModels:[BlogModel]) {
        var tempArray : [Blog] = []
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
        
        self.isLoading.value = false
        
        fetchBlogsData()
    }
    
    func fetchBlogsData() {
        if let result = self.container.fetchData(of: Blog.self, with: nil) as? [Blog]{
            if result.count > 0 {
                var tempArray : [BlogModel] = []
                for item in result{
                    var blogModel = BlogModel(managedObject: item)
                    blogModel.setHeight(for: (tableView.frame.width - 20))
                    tempArray.append(blogModel)
                }
                data.value = tempArray
                
            }else{
                getBlogsData()
            }
        }else{
            getBlogsData()
        }
    }
}
