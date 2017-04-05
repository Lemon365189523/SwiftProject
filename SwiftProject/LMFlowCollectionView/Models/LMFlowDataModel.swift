//
//  LMFlowDataModel.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON
//import HandyJSON


///  布局配置文件模型

struct LMFlowDataModel {
    var className : String?
//    var indexPath : NSIndexPath
    var cellWidth : Float? = 0
    var cellHeight : Float? = 0
    var cellData : Dictionary<String, JSON>?
    
    init?(json:JSON?) {
        guard let json = json else {
            return nil
        }
        
//        guard let indexPath = json["indexPath"].object as? NSIndexPath else {
//            return nil
//        }
        guard let className = json["className"].string,
            let data = json["cellData"].dictionary else {
            return nil
        }
        
        

        
//        self.indexPath = indexPath
        self.className = className
        self.cellData = data
    }
}



