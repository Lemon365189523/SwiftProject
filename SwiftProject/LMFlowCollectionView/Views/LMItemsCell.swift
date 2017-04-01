//
//  LMItemsCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

protocol LMItemsCell {
    
    
    
}

extension LMItemsCell where Self: LMFlowCollectionViewCell {
    
    func setupItemsCell(){
        
        print("ItemsCell")
    }
    
}


extension LMFlowCollectionViewCell: LMItemsCell{
    
    
}
