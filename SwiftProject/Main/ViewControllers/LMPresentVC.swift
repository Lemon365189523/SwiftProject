//
//  LMPresentVC.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/14.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMPresentVC: UIViewController {
    
    var testInt : Int = 0
    
    var backgroundColor : String?
    
    var labelBgColor : String?
    
    var testDic : Dictionary<String, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        
        self.view.backgroundColor = UIColor.colorWithHexString(hex: backgroundColor!)
        
        let label = UILabel.init()
        label.text = String(describing: testInt)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(0)
        }
        
    }
    
    func clickBtn(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
   

}
