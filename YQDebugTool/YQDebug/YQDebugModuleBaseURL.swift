//
//  YQDebugModuleBaseURL.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/3.
//

import UIKit


class YQDebugModuleBaseURL: YQDebugBaseModule {
    
    override class func moduleName() -> String {
        return "请求地址"
    }
    
    override class func moduleDetailName() -> String {
        let buildConfiguretion = UserDefaults.standard.object(forKey: CacheBuildConfiguration) as? String ?? ""
        return buildConfiguretion
    }
    
    override class func moduleCellType() -> YQDebugModuleCellType {
        return .normalType
    }
    
    override class func clickAction() {
        super.clickAction()
        let vc = YQBaseURLController(delegate: YQDebugModuleBaseURL())
        guard  let currentVC: UIViewController = YQDebugListController.yq_currentViewController() else { return }
        currentVC.navigationController?.pushViewController(vc, animated: true)
    }
}

extension YQDebugModuleBaseURL: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        YQDebugModuleBaseURL.clickAction()
    }
}
