//
//  LMFlowCellProtocol.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

let kReloadRowNotification = NSNotification.Name(rawValue: "kReloadRowNotification")

protocol LMFlowCellProtocol {

    
    
}


extension LMFlowCellProtocol where Self: LMFlowCollectionViewCell {
    
    func clickCell(actionString: String) {
        
        print(actionString)
        
    }
    
    func reloadRowWithHeight(row: Int, height: CGFloat){
        NotificationCenter.default.post(name: kReloadRowNotification, object: nil, userInfo: ["row" : row , "height" : height])
        
    }
    
    func reloadRowWithWidth() {
        
    }
    
    func reloadRowWithSize(){
        
        
    }
    
    //传入一个size 按比例刷新高度
    func reloadRowHeightWithSizeRatio(row: Int, size:CGSize, width: CGFloat){
        let ration = width / size.width
        let height = ration * size.height
        
        NotificationCenter.default.post(name: kReloadRowNotification, object: nil, userInfo: ["row" : row , "height" : height])
    }
}


