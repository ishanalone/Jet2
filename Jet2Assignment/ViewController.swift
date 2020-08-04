//
//  ViewController.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import Reachability

class ViewController: UIViewController {
    
    var viewModel : BlogViewModel?

    var reachability: Reachability!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        let container = Container(managedContext)
        viewModel = BlogViewModel(container)
        bindData()
        checkReachability()
        // Do any additional setup after loading the view.
    }

    func checkReachability() {
        reachability = try! Reachability()
        reachability.whenReachable = { reachability in
            self.viewModel!.getBlogsData()
        }
        reachability.whenUnreachable = { _ in
            
            self.viewModel!.fetchBlogsData()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func bindData()  {
        viewModel!.data.addObserver(fireNow: false) { (itemVM) in
            DispatchQueue.main.async {
                print(self.viewModel!.data.value as Any)
                print("count - \(self.viewModel!.data.value.count)")
            }
        }
    }

}

