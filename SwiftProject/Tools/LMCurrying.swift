//
//  LMTargetAction.swift
//  SwiftProject
//
//  Created by Macx on 2017/4/2.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
//就是把接受多个参数的方法变换成接受第一个参数的方法，并且返回接受余下的参数并且返回结果的新方法。
//可以通过柯里化一个方法模板来避免写出很多的重复代码，方便维护。
//柯里化函数的缺点：你不能简单的转换一般函数。如果能将任意接受多参数函数转换为柯里化函数，而 非创建一个新的函数那该是多好啊。另一个缺点是只能按定义的参数顺序来柯里化函数

protocol TargetAction {
    func perfromAction()
}


struct TargetActionWrapper<T: AnyObject> : TargetAction {
    
    weak var target : T?
    
    let action: (T) -> () -> ()

    func perfromAction() {
        if let t = target {
            action(t)()
        }
    }

    
}

//用作标记调用那个target-action
enum ControlEvent{
    case TouchUpInside
    case ValueChange
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    //把event与作为元组的标识， 对象是TargetActionWrapper 
    //action 方法调用类型 感觉这个有很多情况
    func setTarget<T : AnyObject>(target: T, action:@escaping (T) -> () -> (),event: ControlEvent){
        //初始化TargetActionWrapper 保存target 和action
        actions[event] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetActionEvent(controlEvent:ControlEvent){
        actions[controlEvent] = nil
    }
    
    func perfromActionFromControlEvent(controlEvent: ControlEvent){
        actions[controlEvent]?.perfromAction()
    }
}

