//
//  YQBaseURLController.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/3.
//

import UIKit

class YQBaseURLController: UIViewController {
    
    init(delegate: UITableViewDelegate) {
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var dataSource: [String] = {
        let array = ["测试环境", "预生产环境", "生产环境"]
        return array
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.title = "配置baseURL"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
    }
}

extension YQBaseURLController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = dataSource[indexPath.row]
        var buildConfiguration: String!
        if (UserDefaults.standard.object(forKey: CacheBuildConfiguration) as? String) != nil  {
            buildConfiguration = UserDefaults.standard.object(forKey: CacheBuildConfiguration) as? String
        }
        if buildConfiguration == dataSource[indexPath.row] {
            cell.detailTextLabel?.text = "已选择"
        }else
        {
            cell.detailTextLabel?.text = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buildConfiguration = dataSource[indexPath.row]
        UserDefaults.standard.setValue(buildConfiguration, forKeyPath: CacheBuildConfiguration)
        //切换环境的通知
        NotificationCenter.default.post(name: NSNotification.Name(ChangeBuildConfigurationNotification), object: nil, userInfo: nil)
        self.dismissToRootViewController()
    }
}
