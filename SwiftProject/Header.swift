//
//  Header.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/23.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

import SnapKit

import Alamofire

import SwiftyJSON

import ReactiveSwift

import Result

let kSreenHeight = Double(UIScreen.main.bounds.size.height)

let kSreenWight = Double(UIScreen.main.bounds.size.width)

enum LMError: Error {
    case requestError(domain: String)
}


let zhiboHttp = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
