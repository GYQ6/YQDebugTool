//
//  YQDebugBaseModule.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/4.
//

import UIKit

class YQDebugBaseModule: NSObject, YQDebugModuleProtocol{
    
    class func moduleCellType() -> YQDebugModuleCellType {
        return .normalType
    }

}

extension YQDebugBaseModule {
    @objc class func moduleName() -> String {
        return ""
    }
    
    @objc class func moduleDetailName() -> String {
        return ""
    }
    
    @objc class func clickAction() {
        
    }
    
    @objc class func showSW() {
        
    }
    
    @objc class func hiddenSW() {
        
    }
    
    @objc class func moduleCellSwitchValue() -> Bool {
        return false
    }
    
    
}
