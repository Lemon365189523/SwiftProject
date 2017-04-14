//
//  LMHomeViewController.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMHomeViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("跳转", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        btn.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        
        
    }
    
    
    
    func pushVC(){
        let vc = LMFlowViewController()
        self.navigationController?.pushViewController(vc, animated: true)

        
    }


}

