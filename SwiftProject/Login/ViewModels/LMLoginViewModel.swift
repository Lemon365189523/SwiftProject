//
//  LMLoginViewModel.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class LMLoginViewModel: NSObject {
    var userName: MutableProperty<String?> = MutableProperty<String?>(nil)
    var userPw : MutableProperty<String?> = MutableProperty<String?>(nil)
    var logainEnabled : MutableProperty<Bool> = MutableProperty<Bool>(false)
    //用来激活信号的
    var activation = Signal<String?, NoError>.pipe()
    
    //Action三个值 输入值是什么， 输出什么,错误 // 返回信号要关联
    var logAction = Action<Void, Void, NoError> { (input: Void) -> SignalProducer< Void , NoError> in
        return SignalProducer<Void, NoError>.init { (observer, _) in
            observer.send(value:())
            observer.sendCompleted()
        }
    }

    
    override init() {
        super.init()
        bindSiganl()
    }
    
    private func bindSiganl(){
        
        let (signal, observer) = Signal<Signal<String?, NoError>, NoError>.pipe()
        signal.flatten(.merge).observeValues {[weak self] (value) in
            guard let nameVerify = self?.userName.value?.lengthOfBytes(using: .utf8),
            let pwVerify = self?.userPw.value?.lengthOfBytes(using: .utf8) else{
                self?.logainEnabled.value = false
                return
            }
            self?.logainEnabled.value = nameVerify > 5 && pwVerify > 5
        }
        observer.send(value: userName.signal)
        observer.send(value:userPw.signal)
        observer.send(value: activation.output)
        observer.sendCompleted()
        
        logAction.values.observeValues { (event) in
            //做用户密码判断
            
        }
    }
}
