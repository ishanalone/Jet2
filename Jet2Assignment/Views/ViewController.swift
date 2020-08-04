//
//  ViewController.swift
//  Jet2Assignment
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import Reachability
import SnapKit

class ViewController: UIViewController {
    
    var viewModel : BlogViewModel?

    var reachability: Reachability!
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installTableView()
        createViewModel()
        bindData()
        checkReachability()
        // Do any additional setup after loading the view.
    }
    
    func createViewModel() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let container = Container(managedContext)
        viewModel = BlogViewModel(container)
    }
    
    private func installTableView() {
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        tableView.register(BlogCell.self, forCellReuseIdentifier: BlogCell.className())
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
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: BlogCell.className())
        if cell == nil {
            cell = BlogCell(BlogCell.className())
        }
        let data = viewModel?.data.value[indexPath.row]
        if let cell = cell as? BlogCell{
            cell.updateUI(with: data!)
        }
        return cell!
    }
    
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}
