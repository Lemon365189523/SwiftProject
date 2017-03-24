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
    func addLayoutWithKeyboard(view: UIView) ;
}

extension NSObject: LMKeyboardProtocol {
    internal func addLayoutWithKeyboard(view: UIView) {
        
    }
}


