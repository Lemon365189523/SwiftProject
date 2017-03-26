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
    var logainSsEnabled : MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    //Action三个值 输入值是什么， 输出什么,错误 // 返回信号要关联
    var logAction = Action<Void, Void, NoError> { (input: Void) -> SignalProducer< Void , NoError> in
        return SignalProducer{ (observer, disposable) in
            observer.send(value: ())
            observer.sendCompleted()
        }
    }
    
    
    
    override init() {
        super.init()
        bindSiganl()
    }
    
    private func bindSiganl(){
        Signal.combineLatest([userName.signal, userPw.signal]).map { (value) -> Bool in
            return (value[0]?.lengthOfBytes(using: .utf8))! > 5 && (value[1]?.lengthOfBytes(using: .utf8))! > 5
        }.observeValues { [weak self] (enable) in
            self?.logainSsEnabled.value = enable
        }
        
        logAction.values.observeValues { (event) in
            print("网络请求")
        }
    }
}
