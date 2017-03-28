//
//  LMHTTPRequset.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/28.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

//使用面向协议编程封装 网络请求
enum HTTPMethod: String {
    case GET
    case POST
}

protocol Request {
    var host : String {get}
    var path : String {get}
    var method : HTTPMethod {get}
    var parameter : [String : Any] {get}
    
    //添加关联类型 我们可以将回调参数进行抽象
    associatedtype Response
    //但是对于一般的 Response，我们还不知道要如何将数据转为模型。我们可以在 Request 里再定义一个 parse(data:) 方法
    func parse(data: Data) -> Response?
}



struct UserRequest: Request {
    //结构体重所有var 在默认初始化器中实现
    var name : String
    
    let host = "https://api.onevcat.com"
    
    var path: String {
        return "/users/\(name)"
    }
    
    let method: HTTPMethod = .GET
    
    let parameter: [String : Any] = [:]
    
    typealias Response = LMLoginModel
    //Data 转模型

    func parse(data: Data) -> LMLoginModel? {
        return LMLoginModel(data: data)
    }

}

extension Request{
    //定义了可逃逸的 (User?) -> Void 逃逸的只能是函数 返回抽象对象
    func send(handler: @escaping(Response?)-> Void)  {
        let url = URL(string: host.appending(path))!
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            //处理结果
            if let data = data,
                let res = self.parse(data: data){
                DispatchQueue.main.async {
                    handler(res)
                }
            }else{
                DispatchQueue.main.async {
                    handler(nil)
                }
            }
        }
        task.resume()
    }
}


