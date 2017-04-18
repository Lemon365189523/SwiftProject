//
//  LMCarouselCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/18.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation


class LMCarouselCell: LMFlowCollectionViewCell {
    
    lazy var carouseView: LMCarouselView = {
        let view = LMCarouselView.init(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override func setDataModel(model: LMFlowDataModel, flowServer: LMFlowDataServer) {
        super.setDataModel(model: model, flowServer: flowServer)
        carouseView.imageUrls = ["banner1"]//["banner1","banner2","banner3","banner4"]
        carouseView.duration = 3
    }
    
    override func setupSubView() {
        super.setupSubView()
        
        self.addSubview(carouseView)
        carouseView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    
}
