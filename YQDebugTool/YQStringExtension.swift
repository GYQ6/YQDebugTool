//
//  StringExtension.swift
//  YQWeiboDemo
//
//  Created by 郭宇琪 on 2020/11/7.
//

import UIKit

extension String {
    
    /// 获取命名空间
    /// - Returns: 项目命名空间
    public static func getProjectNameSpace() -> String {
        /*
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            print("命名空间失败")
            return ""
        }
        */
        ///cocoapods 导入后 该模块的命名空间为 "YQDebugTool"
        return "YQDebugTool"
    }
    
    /// 将类名字符串转为类
    /// - Parameter className: 类名String
    /// - Returns: 类type
    public static func classWithString(className: String) -> AnyObject? {
        let nameSpace = String.getProjectNameSpace()
        let objClass: AnyClass? = NSClassFromString("\(nameSpace)" + "." + className)
        return objClass
    }

}

