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
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else {
            print("命名空间失败")
            return ""
        }
        return nameSpace
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

