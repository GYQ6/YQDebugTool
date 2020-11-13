//
//  YQDebugModuleProtocol.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/4.
//

import UIKit

enum YQDebugModuleCellType {
    case switchType
    case normalType
}

protocol  YQDebugModuleProtocol {
    ///模块名字
    static func moduleName() -> String
    ///点击事件
    static func clickAction()
    ///模块cell类型
    static func moduleCellType() -> YQDebugModuleCellType
    
    /**以下面协议为可选类型*/
    ///模块详细说明
    static func moduleDetailName() -> String
    ///模块开关的值
    static func moduleCellSwitchValue() -> Bool
}

///可选协议方法
extension YQDebugModuleProtocol {
    ///模块详细说明
    static func moduleDetailName() -> String {
        return ""
    }
    ///debugList中module的cell类型
    static func moduleCellSwitchValue() -> Bool {
        return false
    }
}
