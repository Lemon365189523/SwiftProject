//
//  LMFlowCollectionViewCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import SwiftyJSON

class LMFlowCollectionViewCell: UICollectionViewCell  {
    
    var dataModel : Dictionary<String, JSON>?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataModel(model: Dictionary<String, JSON>){
        dataModel = model
        
        print("cell:\(model)")
    }
}

 



