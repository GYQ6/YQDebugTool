//
//  YQDebugListController.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/3.
//

import UIKit

class YQDebugListController: UIViewController {
    lazy var tableView: UITableView = configTableView()
    lazy var dataSource: [Any] = createDataSource()
    
    deinit {
        //print("YQDebugListController 释放")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        self.title = "Debug工具"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(closeDebugAction))
        self.view.addSubview(self.tableView)
    }
    
    // MARK: - 懒加载
    fileprivate func configTableView() -> UITableView {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }
    
    fileprivate func createDataSource() -> [Any] {
        let array = ["YQDebugModuleBaseURL", "YQDebugModuleFLEX", "YQDebugModuleFPS"]
        return array
    }
}

// MARK: - 事件处理
extension YQDebugListController {
    
    @objc func closeDebugAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configCellUI(moduleName: String, cell: UITableViewCell) {
        let moduleClass = String.classWithString(className: moduleName)
        if let moduleClass = moduleClass as? YQDebugBaseModule.Type {
            cell.textLabel?.text = moduleClass.moduleName()
            cell.detailTextLabel?.text = moduleClass.moduleDetailName()
            cell.accessoryView?.isHidden = moduleClass.moduleCellType() == .normalType ? true : false
            guard let sw: UISwitch = cell.accessoryView as? UISwitch else { return }
            sw.isOn = moduleClass.moduleCellSwitchValue()
        }
    }
    
    @objc func clickSwitchAction(sw: UISwitch) {
        guard let cell = sw.superview as? UITableViewCell else {
            return
        }
        let indexPath: NSIndexPath = tableView.indexPath(for: cell)! as NSIndexPath
        let moduleName = dataSource[indexPath.row] as? String ?? ""
        let moduleClass = String.classWithString(className: moduleName)
        if let moduleClass = moduleClass as? YQDebugBaseModule.Type {
            if sw.isOn {
                moduleClass.showSW()
            }else {
                moduleClass.hiddenSW()
            }
        }
        let currentVC = YQDebugListController.yq_currentViewController()
        currentVC?.navigationController?.popViewController(animated: true)
    }
}

extension YQDebugListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style:.subtitle, reuseIdentifier: "cell")
            let sw = UISwitch()
            sw.addTarget(self, action: #selector(clickSwitchAction(sw:)), for: .valueChanged)
            cell.accessoryView = sw
        }
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.detailTextLabel?.textColor = UIColor.red
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        let moduleName = dataSource[indexPath.row] as? String ?? ""
        configCellUI(moduleName: moduleName, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moduleName = dataSource[indexPath.row] as? String ?? ""
        let moduleClass = String.classWithString(className: moduleName)
        if let moduleClass = moduleClass as? YQDebugBaseModule.Type {
            moduleClass.clickAction()
        }
    }
    
}
