//
//  ViewController.swift
//  YQDebugTool
//
//  Created by 郭宇琪 on 2020/11/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupYQDebugTool()
    }
    
    private func setupYQDebugTool() {
        #if DEBUG
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(long:)))
        longGesture.minimumPressDuration = 1
        self.view.addGestureRecognizer(longGesture)
        YQDebug.default.observerBuildConfigurationBlock = { (buildConfiguration) in
            ///环境切换后 事件处理
            print(buildConfiguration)
        }
        #endif
    }
    @objc func longGestureAction(long: UILongPressGestureRecognizer) {
        if long.state == .began  {
            ///打开YQDebugTool
            YQDebug.default.showYQDebugTool()
        }
    }
    
    
}

