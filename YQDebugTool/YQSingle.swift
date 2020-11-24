//
//  YQSingle.swift
//  YQDebugTool
//
//  Created by 郭宇琪 on 2020/11/24.
//

import UIKit

let YQSingleManger = YQSingle.default

class YQSingle {

    static let `default` = YQSingle()
    var buildName: String?
    
    required init() {}
}
