//
//  LMHomeViewController.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMHomeViewController: UIViewController, LMHomeViewModel, LMFlowDataProtocol {
    lazy var conllectionView: LMFlowCollectionView = {
        let view = LMFlowCollectionView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(conllectionView)
        conllectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItemStyle.plain, target: self, action: #selector(getHomeLayout))
        
        getHomeLayout()
        
        
    }

    func getHomeLayout(){
        //请求配置文件
        getHomeLayout {[weak self] (json, error) in
            if error == nil {
                //LMFlowDataServer协议解析数据然后返回给collectionView
                //配置文件只加载一次
                let modelArr = self?.parseFlowData(json: json)
                self?.conllectionView.setCollectionViewData(viewData: modelArr as! [LMFlowDataModel])
            }else{
                
            }
        }
        
    }

}
