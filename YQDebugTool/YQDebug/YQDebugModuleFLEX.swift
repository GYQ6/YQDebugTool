//
//  YQDebugModuleFLEX.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/3.
//

import UIKit
import FLEX

class YQDebugModuleFLEX: YQDebugBaseModule {
    
    override class func moduleName() -> String {
        return "FLEX工具"
    }
    
    override class func moduleCellType() -> YQDebugModuleCellType {
        return .normalType
    }
    
    override class func clickAction() {
        FLEXManager.shared.showExplorer()
        let currentVC = YQDebugListController.yq_currentViewController()
        currentVC?.navigationController?.popViewController(animated: true)
    }
}
