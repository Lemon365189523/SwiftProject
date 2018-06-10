//
//  LMDynamicItem.swift
//  SwiftProject
//
//  Created by Macx on 2018/6/9.
//  Copyright © 2018年 lemon. All rights reserved.
//

import UIKit

class LMDynamicItem : NSObject ,  UIDynamicItem{
    var center: CGPoint
    var bounds: CGRect
    var transform: CGAffineTransform
    
    override init() {
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        center = CGPoint.zero
        transform = CGAffineTransform()
    }
}
