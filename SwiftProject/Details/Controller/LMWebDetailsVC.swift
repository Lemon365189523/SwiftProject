//
//  LMWebDetailsVC.swift
//  SwiftProject
//
//  Created by Macx on 2018/6/11.
//  Copyright © 2018年 lemon. All rights reserved.
//

import UIKit
import WebKit

class LMWebDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        webView.load(URLRequest(url: URL(string: "https://view.inews.qq.com/w/WXN20180611018297020?refer=nwx&bat_id=1111010493&cur_pos=0&grp_index=0&grp_id=1311010494&rate=0&ft=0&_rp=2&pushid=2018061101&bkt=0&openid=o04IBAM2qXBsdKITQw-sQGR-vYOs&tbkt=A&groupid=1528694969&msgid=0&from=message&isappinstalled=0")!))
    }
    
    func setupUI() {
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let wrapper = UIView()
        scrollView.addSubview(wrapper)
        wrapper.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.top.left.bottom.equalToSuperview()
        }
        
        wrapper.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.top.width.equalToSuperview()
            make.height.equalTo(150)
        }
        
        wrapper.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.width.equalToSuperview()
            make.bottom.equalToSuperview()
            //令主contentSize.height大于屏幕
            make.height.equalTo(600)
        }
        webView.setNeedsLayout()
        webView.layoutIfNeeded()
        
    }

    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        self.view.addSubview(view)
        view.delegate = self
        view.backgroundColor = .red
        return view
    }()

    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        view.scrollView.delegate = self
        view.scrollView.bounces = false
        view.scrollView.isScrollEnabled = false
        return view
    }()
}

extension LMWebDetailsVC : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let contentSize = webView.scrollView.sizeThatFits(CGSize.zero)
        //这种方法不行
        print(contentSize)
    }
    
}

extension LMWebDetailsVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = webView.scrollView.contentSize.height
        if contentHeight > self.scrollView.contentSize.height {
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: contentHeight + 150)
            webView.snp.updateConstraints { (make) in
                make.height.equalTo(contentHeight)
            }
        }
        
    }
}
