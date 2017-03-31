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
    var loginAction = Action<Void, Void, NoError> { (input: Void) -> SignalProducer< Void , NoError> in
        return SignalProducer<Void, NoError>.init { (observer, _) in
            observer.send(value:())
            observer.sendCompleted()
        }
    }

    
    let (loginSignal, loginObserver) = Signal<Any, NSError>.pipe()
    
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
        

        loginAction.values.observeValues {[weak self] (event) in
            //做用户密码判断
            guard let name = self?.userName.value ,
                let password = self?.userPw.value else {
                    self?.loginObserver.send(error: NSError.init(domain: "用户或密码为空", code: -11, userInfo: nil))
                    return
            }
            if name == "Lemon" && password == "123456"{
                
                self!.loginIn()
                
            }else {
                guard let loginErrorBlock =  self?.loginErrorBlock else{
                    return
                }
                loginErrorBlock(NSError.init(domain: "账号或密码错误", code: -11, userInfo: nil))
            }
        }
    }
    
    
    private func loginIn(){
        let url = "http://www.lemon.com/login"
        Alamofire.request(url, method: .post, parameters: nil).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON.init(value)
                guard let loginSuccessBlock = self.loginSuccessBlock else{
                    return
                }
                loginSuccessBlock(json)
            case .failure(let error):
                guard let loginErrorBlock = self.loginErrorBlock else{
                    return
                }
                let err = NSError.error(from: error)
                loginErrorBlock(err)
            }

        }
    }
    
    
    var loginSuccessBlock : ((_ data: JSON)->Void)?
    var loginErrorBlock : ((_ error:NSError)->Void)?
    
    //不知道怎么利用信号做回传到vc 先用回调函数
    public func loginWithToken(loginSuccessBlock:@escaping ((_ data: JSON)->Void),loginErrorBlock:@escaping ((_ error:NSError)->Void)) {
        //请求成功
        self.loginSuccessBlock = loginSuccessBlock
        
        //请求成功
        self.loginErrorBlock = loginErrorBlock
        
    }
}
