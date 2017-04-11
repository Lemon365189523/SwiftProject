//
//  LMHomeViewController.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMHomeViewController: UIViewController, LMHomeViewModel {
    lazy var conllectionView: LMFlowCollectionView = {
        let view = LMFlowCollectionView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    let flowServer = LMFlowDataServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(conllectionView)
        conllectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "刷新", style: UIBarButtonItemStyle.plain, target: self, action: #selector(getHomeLayout))
        
        getHomeLayout()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "更新cell数据", style: UIBarButtonItemStyle.plain, target: self, action: #selector(getHomeLayout))
    }

    func getHomeLayout(){
        //请求配置文件
        getHomeLayout {[weak self] (json, error) in
            if error == nil {
                //LMFlowDataServer协议解析数据然后返回给collectionView
                //配置文件只加载一次
                
                self?.flowServer.parseFlowData(json: json)
                self?.conllectionView.setCollectionflowServer(flowServer: (self?.flowServer)!)
            }else{
                
            }
        }
    }
    
    func getCellData(){
        getImageCellData { (json, error) in
            if error == nil{
                guard let data = json?["data"].dictionary else{return}
                guard let cellId = data["cellId"]?.string,
                    let cellData = data["cellData"]?.dictionary else{return }
                self.conllectionView.updateCellData(cellId: cellId, cellData: cellData)
            }
        }
    }

}
