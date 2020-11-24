//
//  YQFPSLabel.swift
//  YQBuildConfiguration
//
//  Created by 郭宇琪 on 2020/11/4.
//

import UIKit

class YQFPSLabel: UILabel {
    var link: CADisplayLink!
    var count: Int = 0
    var lastTime: TimeInterval = 0
    
    deinit {
        print("YQFPSLabel -> 释放")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        configLink()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configLink() {
        link = CADisplayLink(action: { [weak self] (link) in
            self?.tickAction(link: link)
        })
        
        link.add(to: RunLoop.main, forMode: .common)
    }
    
    @objc func tickAction(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return;
        }
        count += 1
        let delta: TimeInterval = link.timestamp - lastTime
        if delta > 1 {
            lastTime = link.timestamp
            let fps = ceil(Double(count) / delta)
            count = 0
            let attributedText = NSMutableAttributedString(string: "\(fps)FPS")
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.alignment = NSTextAlignment.center
            let allDic = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                          NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            attributedText.addAttributes(allDic, range: NSRange(location: 0, length: attributedText.string.count))
            let dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                      NSAttributedString.Key.foregroundColor: UIColor.green]
            let fpsStr = "\(fps)"
            let range: NSRange = NSRange(location: 0, length: fpsStr.count)
            attributedText.addAttributes(dic, range: range)
            self.attributedText = attributedText
        }
    }
    

}
