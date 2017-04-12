

//
//  LMTargetAction.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/12.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON

class LMTargetAction {
    //单例模式
    static let sharedInstance = LMTargetAction()
    
    private init (){
        
    }
    
    var target : AnyObject?
    
    var action : String?
    
    func setTargetAction(targetAction: Dictionary<String, JSON>){
        //根据target来判断需要做什么
        guard let targetString = targetAction["target"]?.string else {
            print("无效的target>>>>target:\(targetAction["target"])")
            return
        }
        if targetString == ""{
            
        }else if targetString == "" {
            
        }else{
            print("无效的target>>>>target:\(targetAction["target"])")
            return
        }
    }
    
    
    
}


