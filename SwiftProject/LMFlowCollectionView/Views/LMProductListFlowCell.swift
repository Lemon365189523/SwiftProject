//
//  LMProductListFlowCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation


class LMProductListFlowCell: LMFlowCollectionViewCell {
    
    lazy var bgView: UIView = {
        let bg = UIView.init()
        bg.backgroundColor = UIColor.white
        return bg
    }()
    
    lazy var productIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.blue
        return iv
    }()
    
    lazy var titleLB: UILabel = {
        let lb = UILabel()
        lb.text = "dsfdafadafdakfkalkdjf"
        lb.numberOfLines = 2
        return lb
    }()

    
    override func setDataModel(model: LMFlowDataModel, flowServer: LMFlowDataServer) {
        super.setDataModel(model: model, flowServer: flowServer)
        self.backgroundColor = UIColor.groupTableViewBackground
        if model.index % 2 == 0 {
            bgView.snp.updateConstraints({ (make) in
                make.right.equalTo(-3)
                make.left.equalTo(0)
            })
        }else{
            bgView.snp.updateConstraints({ (make) in
                make.left.equalTo(3)
                make.right.equalTo(0)
            })
        }
        
        var newModel = model
        print(model.cellData)
        
        
    }
    
    override func setupSubView() {
        super.setupSubView()
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(self.snp.top).offset(3)
            make.bottom.equalTo(self.snp.bottom).offset(-3)
        }
        
        bgView.addSubview(productIV)
        bgView.addSubview(titleLB)
        
        productIV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(bgView.snp.width)
        }
        
        titleLB.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(productIV.snp.bottom)
            make.bottom.equalTo(0)
        }
        
    }
    
}

