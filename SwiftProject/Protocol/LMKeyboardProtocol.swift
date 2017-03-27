//
//  LMKeyboardProtocol.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import UIKit

protocol LMKeyboardProtocol {
//    func addLayoutWithKeyboard(view: UIView) ;
}


extension LMKeyboardProtocol {
    
    func addLayoutWithKeyboard(view: UIView) {

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
                        make.bottom.equalTo(-height).priority(.required)
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
                view.snp.updateConstraints({ (make) in
//                    make.bottom.equalTo(0).priority(.low)
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


