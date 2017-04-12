//
//  LMTextCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/7.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

class LMTextCell: LMFlowCollectionViewCell {
    
    lazy var textLB: UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = UIColor.orange
        return lb
    }()
    
    override func setDataModel(model: LMFlowDataModel, flowServer: LMFlowDataServer) {
        super.setDataModel(model: model, flowServer: flowServer)
        guard let text = model.cellData?["text"]?.string else {
            return
        }
        textLB.text = text
        let height = text.getStringHeigh( font: textLB.font, width:CGFloat(model.cellWidth!))
        reloadRowWithHeight(row: model.index, height: height )
    }
    
    
    override func setupSubView() {
        super.setupSubView()
        addSubview(textLB)
        textLB.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    
    
}

