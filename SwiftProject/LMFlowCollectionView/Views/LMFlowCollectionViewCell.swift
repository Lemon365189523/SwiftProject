//
//  LMFlowCollectionViewCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMFlowCollectionViewCell: UICollectionViewCell  {
    
    var dataModel : LMFlowCellDataModel?
    
    lazy var numLB: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(numLB)
        numLB.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataModel(model: LMFlowCellDataModel){
        dataModel = model
        numLB.text = String(model.row)
        
    }
}

 



