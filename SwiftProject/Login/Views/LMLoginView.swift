//
//  LMLoginView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

import ReactiveSwift
import ReactiveCocoa
import Result

class LMLoginView: UIView {
    let contentView : UIView = UIView()
    let nameTF : UITextField = UITextField()
    let pwTF : UITextField = UITextField()
    let loginBtn : UIButton = UIButton()
    var viewModel : LMLoginViewModel? = nil{
        didSet(oldValue){
//            self.bindSignal()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.groupTableViewBackground
        self.setSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setSubViews()  {
        self.addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        let nameLB = UILabel()
        nameLB.text = "用户名:"
        let pwLB = UILabel()
        pwLB.text = "密    码:"
        
        contentView.addSubview(nameLB)
        nameLB.sizeToFit()
        nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.height.equalTo(40)
//            make.width.greaterThanOrEqualTo(30)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(nameTF)
        nameTF.snp.makeConstraints { (make) in
            make.left.equalTo(nameLB.snp.right).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(20)
        }
        
        contentView.addSubview(pwLB)
        pwLB.snp.makeConstraints { (make) in
            make.top.equalTo(nameLB.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.greaterThanOrEqualTo(nameLB.snp.width)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(pwTF)
        pwTF.snp.makeConstraints { (make) in
            make.left.equalTo(pwLB.snp.right).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(nameTF.snp.bottom).offset(20)
        }
        
        loginBtn.setTitle("login in", for: .normal)
        loginBtn.backgroundColor = UIColor.blue
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        contentView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(pwTF.snp.bottom).offset(20)
        }
        
//        self.bindSignal1()
        self.bindSignal3()
    }
    
    func bindSignal1(){
        //1.冷信号
        let producer = SignalProducer<String, NoError>.init { (observer, _) in
            print("新的订阅，启动操作")
            observer.send(value: "Hello")
            observer.send(value: "World")
            observer.sendCompleted()
        }
        
        //创建观察者 (多个观察者观察会有副作用)
        let sub1 = Observer<String, NoError>(value: {
            print("观察者1接受信号\($0)")
        })
        
        let sub2 = Observer<String, NoError>(value: {
            print("观察者1接受信号\($0)")
        })
        //观察者订阅信号
        print("观察者1订阅信号")
        producer.start(sub1)
        print("观察者2订阅信号")
        producer.start(sub2)

        
    }
    
    func bindSignal2(){
        
        //2.热信号 (通过管道创建)
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<Int, NoError>.pipe()
        
        Signal.combineLatest(signalA,signalB).observeValues { (value) in
            print("两个热信号收到的值\(value.0) + \(value.1)")
        }
        //订阅信号要在send之前
        signalA.observeValues { (value) in
            print("signalA : \(value)")
        }
        
        observerA.send(value: "sssss")
        //        observerA.sendCompleted()
        observerB.send(value: 2)
        //        observerB.sendCompleted()
        
        observerB.send(value: 100)
        //不sendCompleted和sendError 热信号一直激活
        //        observerB.sendCompleted()
    }
    
    func bindSignal3(){
        //2文本输入框的监听
        nameTF.reactive.continuousTextValues.observeValues { (text) in
            print(text ?? "")
            
        }
        //监听黏贴进来的文本
        let result = nameTF.reactive.values(forKeyPath: "text")
        result.start { (text) in
            print(text)
        }
    }
    
}



