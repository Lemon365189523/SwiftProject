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
    
}

struct  LMFlowDataServer : LMFlowDataProtocol{
    
    
}

extension LMFlowDataProtocol{
    
    func parseFlowData(json: JSON?) -> [LMFlowDataModel?]{
        let array = json?["data"]
        var modelArr = [LMFlowDataModel?]()
        for (_, item) in array! {
            modelArr.append(LMFlowDataModel.init(json: item))
        }
        return modelArr
    }
    
}


