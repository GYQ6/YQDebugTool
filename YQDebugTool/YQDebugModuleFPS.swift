//
//  YQDebugModuleFPS.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/3.
//

import UIKit

var YQIPhoneX: Bool {
    var tmp = false
    if #available(iOS 11.0, *), let safeBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, safeBottom > 0 {
        tmp = true
    }
    return tmp
}

class YQDebugModuleFPS: YQDebugBaseModule {
    deinit {
        YQDebugBaseModule.hiddenSW()
    }
    ///返回为枚举类型的协议方法, 不支持在分类中重写
    override class func moduleCellType() -> YQDebugModuleCellType {
        return .switchType
    }
    
}

// MARK: - 重写父类的相关方法
extension YQDebugModuleFPS {
    
    override class func moduleName() -> String {
        return "FPS显示"
    }
    
    override class func showSW() {
        print("打开")
        if YQDebugModuleFPS.isFPDShow() { return }
        YQDebugModuleFPS.createFPSLabel()
    }
    
    override class func hiddenSW() {
        print("关闭")
        if YQDebugModuleFPS.isFPDShow() {
            guard let window: UIWindow = YQDebugModuleFPS.getWindow() else { return }
            for (_, label) in window.subviews.enumerated() {
                if label is YQFPSLabel {
                    label.removeFromSuperview()
                }
            }
        }
    }
    
}


extension YQDebugModuleFPS {
    
    override class func moduleCellSwitchValue() -> Bool {
        return YQDebugModuleFPS.isFPDShow()
    }
    
    class func isFPDShow() -> Bool {
        guard let window: UIWindow = YQDebugModuleFPS.getWindow() else { return false}
        for view in window.subviews {
            if view is YQFPSLabel {
                window.bringSubviewToFront(view)
                return true
            }
        }
        return false
    }
    
    class func getWindow() -> UIWindow? {
        guard let window: UIWindow = UIApplication.shared.keyWindow else { return nil}
        return window
    }
    
    @discardableResult
    class func createFPSLabel() -> YQFPSLabel? {
        let label = YQFPSLabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        guard let window: UIWindow = YQDebugModuleFPS.getWindow() else { return nil}
        window.addSubview(label)
        window.bringSubviewToFront(label)
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[label(60)]-0-|", options: [], metrics: ["margin": 4], views: ["label": label])
        let marginBottom = YQIPhoneX ? 34 : 0
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[label(20)]-\(marginBottom)-|", options: [], metrics: ["margin": 4], views: ["label": label]))
        window.addConstraints(constraints)
        return label
    }
}
