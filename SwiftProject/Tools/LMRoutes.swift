//
//  LMRoutes.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/13.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON

enum LMRoutesType : String{
    case PustVC = "PushVC"
    case PresentVC = "PresentVC"
}

class LMRoutes{
    
    static let shared = LMRoutes()
    
    private init(){}
    
    func isLMRoutesUr(url: URL) -> Bool{
        return url.absoluteString.hasPrefix("LM://")
    }
    
    func routesWithUrl(url: URL?){
        guard let workUrl = url else {
             print(">>>>>>无效的URL:\(url)")
            return
        }
        if workUrl.absoluteString.whitespacesIsEmple() || !self.isLMRoutesUr(url: workUrl){
            print(">>>>>>url为空或者不是LMRoutes指定的url:\(workUrl.absoluteString)")
            return
        }
       
        let json = JSON.init(workUrl.queryParameters)
        
        let type = LMRoutesType(rawValue:json["type"].string!)
        
        if let routesType = type {
            switch routesType {
            case .PresentVC:
                print("PresentVC")
                
            case .PustVC:
                
                print("PushVC")
            }
        }else{
            print(">>>>>>传入无用的type:\(json["type"].string)")
        }

    }
    
}


extension URL{
    
    var queryParameters: [String : String] {
        get {
            var dic = [String : String]()
            //去掉LM://
            let host = self.host! as String
            let array = host.components(separatedBy: "&")
            
            for index in 0..<array.count {
                let queryComponent = array[index]
                let compArray = queryComponent.components(separatedBy: "=")
                if compArray.count == 2 {
                    let key = compArray.first
                    let value = compArray.last
                    dic.updateValue(value!, forKey: key!)
                }
            }
            
            return dic
        }
    }
}
