//
//  LMStringExtension.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/7.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation


extension String {
    
    func getClassName() -> String {
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as! String + "." + self
    }
    
    // 类型方法 String是结构体
    static func getClassNameWithString(className: String) -> String {
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as! String + "." + className
    }
    
    //知道宽度获取文字高度
    func getStringHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        
        let statusLabelText = NSString.init(string: self)
        
        let size =  CGSize.init(width: width, height: CGFloat(MAXFLOAT))
        
        let dic = [NSFontAttributeName: font]
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic , context:nil).size
        
        return strSize.height + 1
        
    }
    
    //判断字符是否为空
    func whitespacesIsEmple() -> Bool{
        let string = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return string.isEmpty
    }
    

    
}

