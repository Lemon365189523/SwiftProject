//
//  LMFlowDataProtocol.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/1.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation


protocol LMFlowDataServer {
    func parseFlowData(data: Data) -> [LMFlowDataModel]
}

extension LMFlowDataServer{
    
    
    
}
