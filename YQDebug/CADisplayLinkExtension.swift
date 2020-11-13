//
//  CADisplayLinkExtension.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/4.
//

import UIKit

public typealias ActionClosure = (_ link: CADisplayLink) -> Void

extension CADisplayLink {
    private struct AssociatedKeys {
        static var actionClosure = "actionClosure"
    }
    public var actionClosure: ActionClosure? {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.actionClosure) as? ActionClosure ?? nil
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.actionClosure, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    public convenience init(action actionClosure: @escaping ActionClosure) {
        self.init()
        self.actionClosure = actionClosure
        self.init(target: self, selector: #selector(linkAction(link:)))
    }
    
    @objc fileprivate func linkAction(link: CADisplayLink) {
        guard let actionClosure = self.actionClosure else { return }
        actionClosure(link)
    }
    
    
    
}
