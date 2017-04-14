//
//  LMWebViewController.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/14.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import WebKit

class LMWebViewController: UIViewController {
    
    lazy private var webView: WKWebView = {
        let view = WKWebView.init()
        return view
    }()
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        
        
    }

    

}
