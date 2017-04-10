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
    var index : Int = 0
    var cellWidth : Double? = 0
    var cellHeight : Double? = 0
    var cellData : Dictionary<String, JSON>?
    var cellId : String? = "" 
    var backgroundColor : String? = "ffffff"
    var needSetData : Bool = true
    
    init?(json:JSON?) {
        guard let json = json else {
            return nil
        }
        
        if let className = json["className"].string{
            self.className = className
        }
        
        if  let data = json["cellData"].dictionary{
            self.cellData = data
        }
        
        if var cellHeight = json["cellHeight"].string {
            if cellHeight.hasSuffix("%") {
                cellHeight.remove(at: cellHeight.index(before: cellHeight.endIndex))
                self.cellHeight = Double(kSreenHeight * Double(cellHeight)! / 100.0)
            }else{
                self.cellHeight = Double(cellHeight)
            }
        }
        
        if var cellWidth = json["cellWidth"].string {
            if cellWidth.hasSuffix("%") {
                cellWidth.remove(at: cellWidth.index(before: cellWidth.endIndex))
                self.cellWidth = Double(kSreenWight * Double(cellWidth)! / 100.0)
            }else{
                self.cellWidth = Double(cellWidth)
            }
        }
        
        
        if let bgColor = json["backgroundColor"].string {
            backgroundColor = bgColor
        }
        
        
    }
}



