//
//  LMFlowDataProtocol.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol LMFlowDataProtocol {
    //控制只读
    //var dataArray : [LMFlowDataModel?] {get}
    func updateDataArray(modelArray: [LMFlowDataModel?]) -> [LMFlowDataModel?]
    
    func insertCellData(cellData:Dictionary<String, JSON>,cellId:String)
    
    func updateModel(index:Int,model: LMFlowDataModel?)
}

class LMFlowDataServer : LMFlowDataProtocol{
    //限制外部设置
    private(set) var dataArray: [LMFlowDataModel?] = []
    
    var cache : NSCache<AnyObject, AnyObject>? = NSCache.init()
    
    internal func updateDataArray(modelArray: [LMFlowDataModel?]) -> [LMFlowDataModel?] {
        dataArray = modelArray
        //在这里做缓存操作
        
        
        return dataArray
    }
    
    ///MARK 插入cellData
    func insertCellData(cellData: Dictionary<String, JSON>, cellId: String) {
        for (index,model) in self.dataArray.enumerated() {
            guard let cellIdWithModel = model?.cellId else {continue}
            if cellIdWithModel == cellId && !cellIdWithModel.isEmpty {
                var updateModel = model
                updateModel?.cellData = cellData
                self.dataArray[index] = updateModel
            }
        }
    }
    
    ///MARK 插入模型数组
    func insertModels(models:[LMFlowDataModel?]){
//        var arr = dataArray + models
       
        for model in models {
            dataArray.append(model)
        }
        
    }
    
    ///MARK 跟新模型数组中某行数据
    func updateModel(index: Int, model: LMFlowDataModel?) {
        self.dataArray[index] = model
    }
    
    ///MARK 根据cellId来获取数组下标
    func getIndex(cellId:String) -> Int? {
        for item in self.dataArray {
            guard let cellIdWithModel = item?.cellId else {
                continue
            }
            if cellIdWithModel == cellId && !cellIdWithModel.isEmpty {
                return item?.index
            }
        }
        return nil
    }
    
    
}

extension LMFlowDataProtocol{
    
    func parseFlowData(json: JSON?) {
        let array = json?["data"]
        var modelArr = [LMFlowDataModel?]()
        for (index, item) in array! {
            var model = LMFlowDataModel.init(json: item)
            model?.index = Int(index)!
            modelArr.append(model)
        }
        
        _ = self.updateDataArray(modelArray: modelArr)
    }
    
}


