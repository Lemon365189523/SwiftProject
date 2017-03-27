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
import Alamofire
import SwiftyJSON

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
            self?.logainEnabled.value = nameVerify > 1 && pwVerify > 1
        }
        observer.send(value: userName.signal)
        observer.send(value:userPw.signal)
        observer.send(value: activation.output)
        observer.sendCompleted()
        
        logAction.values.observeValues {[weak self] (event) in
            //做用户密码判断
            guard let name = self?.userName.value ,
                let password = self?.userPw.value else {return}
            if name == "lemon" && password == "123456"{
                print("登录成功")
                self!.loginIn()
            }else {
                print("账号密码错误")
                //http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1
            }
        }
    }
    
    private func loginIn(){
        let url = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
        Alamofire.request(url, method: .post, parameters: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON.init(value)
                print(json)
            case .failure(let error):
                print("失败：\(error) ")
            }

        }
    }
    
}
