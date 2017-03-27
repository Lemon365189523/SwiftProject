//
//  LMKeyboardProtocol.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol LMKeyboardProtocol {
//    func addLayoutWithKeyboard(view: UIView) ;
}


extension LMKeyboardProtocol {
    
    func addLayoutWithKeyboard(view: UIView) {
        var bottomConstraint : Constraint?
        //bottomConstraint.updateOffset(60) 可以这样单个约束更新
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil).map({ (notification) -> (Double  , Double) in
            guard let rect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect,
                let duration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? Double
            else{
                return (0 , 0)
            }
           
            return ( duration , Double(rect.height))
        }).observeValues { (duration, height) in
            let viewBottom = view.frame.size.height + view.frame.origin.y
            if Double(viewBottom) + height > kSreenHeight {
                UIView.animate(withDuration: duration, animations: {
                    view.snp.makeConstraints({ (make) in
                       bottomConstraint = make.bottom.equalTo(-height).priority(.required).constraint
                    })
                    guard let superView = view.superview else {
                        view.layoutIfNeeded()
                        return;
                    }
                    superView.layoutIfNeeded()
                })

            }
            
        }
        
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue:"UIKeyboardWillHideNotification"), object: nil).map({ (notification) -> (Double  , Double) in
        guard let rect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect,
        let duration = notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? Double
        else{
            return (0 , 0)
        }
        
        return ( duration , Double(rect.height))
            
        }).observeValues { (duration, height) in
            UIView.animate(withDuration: duration, animations: {
                guard let constraint = bottomConstraint else {return}
                view.snp.updateConstraints({ (make) in
                    constraint.deactivate()
                })
                guard let superView = view.superview else {
                    view.layoutIfNeeded()
                    return;
                }
                superView.layoutIfNeeded()
            })
        }
    }
}


