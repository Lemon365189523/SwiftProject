//
//  LMTimerExtension.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/18.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

extension Timer {
    
    class func lm_scheduledTimerWithTimeInterval(interval: TimeInterval,block:()->(), repeats: Bool) -> Timer{
        return self.scheduledTimer(timeInterval: interval, target: self, selector: #selector(lm_blockInvoke(timer:)), userInfo: block, repeats: repeats)
    }
    
    class func lm_blockInvoke(timer: Timer){
        let userInfo = timer.userInfo
        let block = userInfo as! ()->()
        block()
    }
}

