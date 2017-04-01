//
//  LMTabBar.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

protocol LMTabBarDelegate {
    func selectBtn() ;
}

class LMTabBar: UITabBar {
    
    var tabbarDelegate : LMTabBarDelegate?
    
    lazy var centerBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setBackgroundImage(UIImage(named: "nav_bg_3_1"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "nav_bg_3_2"), for: .highlighted)
        return btn
    }()
    
    lazy var centerView: UIView = {
        let centerView = UIView()
        centerView.backgroundColor = UIColor.purple
        return centerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(centerView)
        centerView.addSubview(centerBtn)
        centerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        centerBtn.reactive.controlEvents(.touchUpInside).observeValues({[weak self] (button) in
            guard let tabbarDelegate = self?.tabbarDelegate else{
                return
            }
            tabbarDelegate.selectBtn()
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonY = 0
        let buttonW = self.frame.width / 5
        let buttonH = self.frame.height
        
        centerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.width.equalTo(self.frame.width/5)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        var index = 0
        for item in self.subviews {
            if item.isKind(of: NSClassFromString("UITabBarButton")!) {
                let count = index > 1 ? (index + 1) : index
                let buttonx = Double(buttonW) * Double(count)
                item.frame = CGRect.init(x: CGFloat(buttonx), y: CGFloat(buttonY), width: buttonW, height: buttonH)
                index += 1
            }
            
        }
       
    }
}


