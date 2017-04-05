//
//  LMTargetAction.swift
//  SwiftProject
//
//  Created by Macx on 2017/4/2.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation


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

enum ControlEvent{
    case TouchUpInside
    case ValueChange
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T : AnyObject>(target: T, action:@escaping (T) -> () -> (),event: ControlEvent){
        actions[event] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetActionEvent(controlEvent:ControlEvent){
        actions[controlEvent] = nil
    }
    
    func perfromActionFromControlEvent(controlEvent: ControlEvent){
        actions[controlEvent]?.perfromAction()
    }
}

