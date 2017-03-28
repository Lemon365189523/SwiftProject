//
//  LMLoginModel.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import SwiftyJSON

struct LMLoginModel {
    let userName : String
    let message : String
    
    init?(data: Data) {
        //各种类型判断
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        guard let name = obj?["name"] as? String else {
            return nil
        }
        guard let message = obj?["message"] as? String else {
            return nil
        }
        
        self.message = message
        self.userName = name
        
    }
}
