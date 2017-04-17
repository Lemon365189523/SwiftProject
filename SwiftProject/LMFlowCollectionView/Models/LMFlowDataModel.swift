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

enum ControlType : Int{
    case ControlOnlyOneVersion = 1//只控制一个版本
    case ControlAscending = 2//升序，某个版本以上
    case ControlDescending = 3//降序，某个版本以下
}

struct LMFlowDataModel {
    var className : String?
    var index : Int = 0
    var cellWidth : Double? = 0
    var cellHeight : Double? = 0
    var cellData : Dictionary<String, JSON>?
    var cellId : String? = "" 
    var backgroundColor : String? = "ffffff"
    var needSetData : Bool = true
    var action : String? = ""
    ///是否实现版本控制
    var needRevisionControl : Bool = false
    var controlVersion : String?
    var controlType : ControlType?
    
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
        
        if let cellId = json["cellId"].string{
            self.cellId = cellId
        }else{
            self.cellId = className! + String(index)
        }
        
        if let action = json["action"].string {
            self.action = action
        }
        
    }
    
    init() {
        
    }
    
}



