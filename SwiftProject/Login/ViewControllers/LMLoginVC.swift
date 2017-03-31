//
//  LMLoginVC.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import MBProgressHUD
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
        

        loginViewModel.loginWithToken(loginSuccessBlock: { (data) in
            let main = LMTabBarController()
            UIApplication.shared.keyWindow?.rootViewController = main
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }) { (error) in
            print(error)
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text;
            hud.label.text = error.domain
            hud.hide(animated: true, afterDelay: 1)
            
        }
    }

 


}
