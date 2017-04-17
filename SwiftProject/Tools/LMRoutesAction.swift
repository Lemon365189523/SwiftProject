//
//  LMRoutesAction.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/13.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol LMRoutesAction {
    
}

extension LMRoutesAction{
    
    func currentTopController() -> UIViewController {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        return currentTopViewController(rootViewController: rootViewController!)
    }
    
    func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
        if (rootViewController.isKind(of: UITabBarController.self)) {
            let tabBarController = rootViewController as! UITabBarController
            return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
        }
        
        if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            return currentTopViewController(rootViewController: navigationController.visibleViewController!)
        }
        
        if ((rootViewController.presentedViewController) != nil) {
            return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
        }
        return rootViewController
    }
    
    
    func initController(json:JSON) -> UIViewController? {
        
        guard let className = json["class"].string?.getClassName() else{
            return nil
        }
        let cls: AnyClass? = NSClassFromString(className)
        if let controller = cls as? UIViewController.Type {
            let viewController : UIViewController = controller.init()
            
//            var outCount : UInt32 = 0
//            let properties = class_copyPropertyList(cls, &outCount)
//            //获取vc的属性
//            for i in 0..<outCount {
//                guard let propertyName = NSString.init(cString: property_getName(properties![Int(i)]), encoding: String.Encoding.utf8.rawValue) else {
//                    continue
            //                }
            //
            //            }
            
            //用Mirror反射来获取对象的属性，该属性是自己定义的属性 kvc不支持基本数据类型的结构体
            let children = Mirror(reflecting: viewController).children.filter { $0.label != nil }
            for child in children {
                if let key = child.label, let val = json[key].string {
                    let propertyType = type(of: child.value)
                    switch propertyType {
                    case _ as String.Type, _ as Optional<String>.Type:
                        viewController.setValue(val, forKey: key)
                    case _ as Int.Type:
                        viewController.setValue(Int(val), forKey: key)
                    case _ as Optional<Int>.Type:
                        assert(false, "LMRouter --> 参数不支持Optional<Int>类型，改成Int类型")
                    case _ as Float.Type:
                        viewController.setValue(Float(val), forKey: key)
                    case _ as Optional<Float>.Type:
                        assert(false, "LMRouter --> 参数不支持Optional<Float>类型，改成Float类型")
                        
                    case _ as Double.Type:
                        viewController.setValue(Double(val), forKey: key)
                    case _ as Optional<Double>.Type:
                        assert(false, "LMRouter --> 参数不支持Optional<Double>类型，改成Double类型")
                        
                    case _ as Bool.Type:
                        viewController.setValue(Bool(val), forKey: key)
                    case _ as Optional<Bool>.Type:
                        assert(false, "LMRouter --> 参数不支持Optional<Bool>类型，改成Bool类型")
                        
                    case _ as Optional<Dictionary<String, String>>.Type, _ as Dictionary<String, String>.Type:
                        //转的也是转成字符串的字典，在vc拿到字典后再做解析操作
                        //%7B { 
                        //%7D }
                        //%3A =
                        
                        var dicString = val
                        dicString.remove(at: dicString.index(before: dicString.endIndex))
                        dicString.remove(at: dicString.startIndex)
                        let array = dicString.components(separatedBy: ",")
                        var dic = Dictionary<String, String>.init()
                        for item in array {
                            let arr = item.components(separatedBy: ":")
                            dic[arr[0]] = arr[1]
                        }
                        
                        viewController.setValue(dic, forKey: key)
                    default:
                        break
                    }
                }
            }
            
            return viewController
        }
        return nil
    }
    

    
}






