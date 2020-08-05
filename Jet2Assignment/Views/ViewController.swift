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
    
    lazy var footerView : UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var loader : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .white
        loader.startAnimating()
        return loader
    }()
    
    lazy var loadingLbl : UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "Fetching blogs..."
        lbl.textAlignment = .left
        lbl.textColor = .white
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installTableView()
        installFooterView()
        createViewModel()
        bindData()
        checkReachability()
        viewModel!.fetchBlogsData()
        self.navigationItem.title = "Articles"
        // Do any additional setup after loading the view.
    }
    
    func createViewModel() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let container = Container(managedContext)
        viewModel = BlogViewModel(container, tableView: tableView)
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
    
    func installFooterView() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        footerView.backgroundColor = .black
        footerView.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
            make.width.height.equalTo(50)
        }
        
        footerView.addSubview(loadingLbl)
        loadingLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(loader.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview()
        }
        
    }

    
    func checkReachability() {
        reachability = try! Reachability()
        reachability.whenReachable = { reachability in
            //self.viewModel!.getBlogsData()
            self.viewModel!.isReachable = true
        }
        reachability.whenUnreachable = { _ in
            
            self.viewModel!.isReachable = false
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
        
        viewModel!.isLoading.addObserver { (value) in
            DispatchQueue.main.async {
                if value{
                    self.tableView.tableFooterView = self.footerView
                }else{
                    self.tableView.tableFooterView = nil
                    
                }
            }
            
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !(viewModel?.isLoading.value)!){
            self.viewModel!.getBlogsData()
        }
    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.value.count ?? 0
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
        let blogModel = viewModel!.data.value[indexPath.row]
        var baseHeight : CGFloat = 130
        if blogModel.media.count > 0{
            baseHeight = 300
        }
        if let height = blogModel.contentHeight{
            return baseHeight + height + 10
        }
        return 360
    }
}


