//
//  LMHomeViewModel.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import Alamofire
import SwiftyJSON

protocol LMHomeViewModel {
    
}

extension LMHomeViewModel {
    func getHomeLayout()  {
        let url = "http://www.lemon.com/home_layout"
        LMHttpRequset.POST(url: url, parameters: nil, successBlock: { (data) in
            
        }) { (error) in
            
        }
    }
}


