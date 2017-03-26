//
//  LMLoginView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

import ReactiveSwift
import ReactiveCocoa
import Result

class LMLoginView: UIView {
    let contentView : UIView = UIView()
    let nameTF : UITextField = UITextField()
    let pwTF : UITextField = UITextField()
    let loginBtn : UIButton = UIButton()
    var viewModel : LMLoginViewModel? = nil{
        didSet(oldValue){
            self.bindSignal()
        }
    }
    
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
        contentView.backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        let nameLB = UILabel()
        nameLB.text = "用户名:"
        let pwLB = UILabel()
        pwLB.text = "密    码:"
        
        contentView.addSubview(nameLB)
        nameLB.sizeToFit()
        nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.height.equalTo(40)
//            make.width.greaterThanOrEqualTo(30)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(nameTF)
        nameTF.snp.makeConstraints { (make) in
            make.left.equalTo(nameLB.snp.right).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(pwLB)
        pwLB.snp.makeConstraints { (make) in
            make.top.equalTo(nameLB.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.greaterThanOrEqualTo(nameLB.snp.width)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(pwTF)
        pwTF.snp.makeConstraints { (make) in
            make.left.equalTo(pwLB.snp.right).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(nameTF.snp.bottom).offset(20)
        }
        
        loginBtn.setTitle("login in", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor.lightGray
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(pwTF.snp.bottom).offset(20)
        }
        
    }
    
    func bindSignal() {
        guard viewModel == nil else {return}
        viewModel!.userName <~ nameTF.reactive.continuousTextValues
        viewModel!.userPw <~ pwTF.reactive.continuousTextValues
        loginBtn.reactive.isEnabled <~ viewModel!.logainSsEnabled
        let _ = viewModel?.logainSsEnabled.signal.observeValues({[weak self] (enable) in
            self?.loginBtn.backgroundColor = enable ? UIColor.blue : UIColor.lightGray
        })
        loginBtn.reactive.pressed = CocoaAction<UIButton>((viewModel?.logAction)!)
    
    }
    

}



