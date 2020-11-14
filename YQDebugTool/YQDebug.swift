//
//  YQDebug.swift
//  YTVIP
//
//  Created by 郭宇琪 on 2020/11/13.
//  Copyright © 2020 何志志. All rights reserved.
//

import UIKit

typealias ObserverBuildConfigurationBlock = (_ buildName: YQBuilConfigurationEnum) -> Void
enum YQBuilConfigurationEnum {
    case YQDebug, YQPreRelease, YQRelease
}
let CacheBuildConfiguration = "CacheBuildConfiguration"
let ChangeBuildConfigurationNotification = "ChangeBuildConfiguration"

class YQDebug {
    
    static let `default` = YQDebug()
    var observerBuildConfigurationBlock: ObserverBuildConfigurationBlock?
    var blackList: [String]? = ["YQBaseURLController", "YQDebugListController"]
    required init() {
        observerChangeBuildConfigurationNotification()
    }

    public func showYQDebugTool() {
        let moduleName = "YQDebugListController"
        guard let moduleClass = String.classWithString(className: moduleName) else { return }
        if let moduleClass = moduleClass as? UIViewController.Type {
            let debugVC: UIViewController = moduleClass.init()
            guard let currentVC = UIViewController.yq_currentViewController() else { return }
            guard (self.blackList?.contains( type(of: currentVC).description())) != nil else {
                return
            }
            if let naVC = currentVC as? UINavigationController {
                naVC.pushViewController(debugVC, animated: true)
            }else {
                currentVC.navigationController?.pushViewController(debugVC, animated: true)
            }
        }
        
    }
    
    private func observerChangeBuildConfigurationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getChangeBuildConfigurationNotificationAction(noti:)), name: NSNotification.Name(rawValue: ChangeBuildConfigurationNotification), object: nil)
    }
    
    @objc func getChangeBuildConfigurationNotificationAction(noti: Notification) {
        ///修改环境
        guard let buildConfiguration = UserDefaults.standard.object(forKey: CacheBuildConfiguration) as? String else { return }
        switch buildConfiguration {
        case "测试环境":
            self.observerBuildConfigurationBlock?(.YQDebug)
        case "预生产环境":
            self.observerBuildConfigurationBlock?(.YQPreRelease)
        case "生产环境":
            self.observerBuildConfigurationBlock?(.YQRelease)
        default:
            self.observerBuildConfigurationBlock?(.YQRelease)
        }
    }
}

