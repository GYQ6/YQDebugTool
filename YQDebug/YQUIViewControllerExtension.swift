//
//  UIViewControllerExtension.swift
//  YTVIP
//
//  Created by 郭宇琪 on 2020/11/12.
//  Copyright © 2020 何志志. All rights reserved.
//

import UIKit

extension UIViewController {

    /// 获取当前ViewController
    class func yq_currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return yq_currentViewController(base: nav.visibleViewController)
        }else if let tab = base as? UITabBarController {
            return yq_currentViewController(base: tab.selectedViewController)
        }else if let presented = base?.presentedViewController {
            return yq_currentViewController(base: presented)
        }else {
            return subViewController(base)
        }
    }
    
    /// 判断是否有子控制器
    class func subViewController(_ baseVc: UIViewController?) -> UIViewController? {
        if let count = baseVc?.children.count, count > 0 {
            return subViewController(baseVc?.children.last)
        }else {
            return baseVc
        }
    }

}
