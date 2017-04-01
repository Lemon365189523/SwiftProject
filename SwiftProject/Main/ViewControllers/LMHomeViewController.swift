//
//  LMHomeViewController.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMHomeViewController: UIViewController {
    lazy var conllectionView: LMFlowCollectionView = {
        let view = LMFlowCollectionView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(conllectionView)
        conllectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        

        
    }



}
