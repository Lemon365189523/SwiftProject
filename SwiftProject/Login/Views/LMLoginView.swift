//
//  LMLoginView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMLoginView: UIView {
    let contentView : UIView = UIView()
    let nameTF : UITextField = UITextField()
    let pwTF : UITextField = UITextField()
    let loginBtn : UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.groupTableViewBackground
        self.setSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setSubViews()  {
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        let nameLB = UILabel()
        nameLB.text = "用户名:"
        let pwLB = UILabel()
        pwLB.text = "密码:"
        
        contentView.addSubview(nameLB)
        nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.height.equalTo(40)
            make.width.greaterThanOrEqualTo(30)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(nameTF)
        nameTF.snp.makeConstraints { (make) in
            make.left.equalTo(nameLB.snp.right)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(pwLB)
        pwLB.snp.makeConstraints { (make) in
            make.top.equalTo(nameLB.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.greaterThanOrEqualTo(30)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(pwTF)
        pwLB.snp.makeConstraints { (make) in
            
        }
    }
    
}



