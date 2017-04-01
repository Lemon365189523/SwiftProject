//
//  LMTestCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

protocol LMTestCell {
//    var label : UILabel{get set}
    
    
}

extension LMTestCell where Self: LMFlowCollectionViewCell {

    func setupTestCell(){
        
        print("ddd\(dataModel)");
    }
    
    
}

extension LMFlowCollectionViewCell : LMTestCell{
    
}

