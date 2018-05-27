//
//  LMTabBar.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

protocol LMTabBarDelegate {
    func selectCustomBar( _ tabBar : LMTabBar) ;
}

protocol LMTabBarDataSource {
    func numberOfCustomBarItem(_ tabBar : LMTabBar) -> Int
    func customBarItem(_ tabBar: LMTabBar) -> UIView
}

class LMTabBar: UITabBar {
    
    var tabbarDelegate : LMTabBarDelegate?
    
    var tabBarDataSource : LMTabBarDataSource?
    
    private var finishLayout = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (tabBarDataSource != nil) , ((tabBarDataSource?.numberOfCustomBarItem(self)) != nil) ,(tabBarDataSource?.customBarItem(self)) != nil {
            
            let buttonY = 0
            let buttonW = self.frame.width / 5
            let buttonH = self.frame.height
            var index = 0
            let number = tabBarDataSource?.numberOfCustomBarItem(self)
            
            for item in self.subviews {
                if item.isKind(of: NSClassFromString("UITabBarButton")!) {
                    let count = index >= number! ? (index + 1) : index
                    let buttonx = Double(buttonW) * Double(count)
                    item.frame = CGRect.init(x: CGFloat(buttonx), y: CGFloat(buttonY), width: buttonW, height: buttonH)
                    index += 1
                }
                
            }
            if finishLayout == false{
                let customView = tabBarDataSource?.customBarItem(self)
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(selectedCustomBar))
                customView?.addGestureRecognizer(tap)
                self.addSubview(customView!)
                customView?.snp.makeConstraints({ (make) in
                    make.width.equalTo(buttonW)
                    make.bottom.equalTo(0)
                    make.left.equalTo(buttonW * CGFloat(number!))
                })
                finishLayout = true
            }
        }
    }
    
    @objc private func selectedCustomBar(){
        guard let delegate = self.tabbarDelegate else {
            return
        }
        delegate.selectCustomBar(self)
    }
}


