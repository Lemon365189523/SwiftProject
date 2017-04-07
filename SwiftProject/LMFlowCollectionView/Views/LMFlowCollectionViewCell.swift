//
//  LMFlowCollectionViewCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import SwiftyJSON

class LMFlowCollectionViewCell: UICollectionViewCell, LMFlowCellProtocol {
    
    var dataModel : LMFlowDataModel?
    
    //var delegate : LMFlowDataProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataModel(model: LMFlowDataModel){
        dataModel = model
        
        
    }
    
    func setupSubView() {
        
    }
}

 



