//
//  LMLoginVC.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMLoginVC: UIViewController {
    lazy var loginView: LMLoginView = LMLoginView()
    var loginViewModel : LMLoginViewModel = LMLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        loginView.viewModel = loginViewModel
        

    }

 


}
