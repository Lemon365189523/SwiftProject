
//
//  LMStretchImageViewCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/11.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class LMStretchImageViewCell: LMFlowCollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let control = Control()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("方法的柯里化", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    
    override func setDataModel(model: LMFlowDataModel, flowServer: LMFlowDataServer) {
        super.setDataModel(model: model, flowServer: flowServer)
        guard let imageName = model.cellData?["imageName"]?.string  else {
            imageView.image = UIImage.init()
            return
        }
        imageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageName)!),  progressBlock: nil) {
            [weak self] (image, error, CacheType, nil) in
            self?.flowView?.reloadRowHeightWithSizeRatio(row: model.index, size: (image?.size)!, width: (self?.frame.width)!)
        }
        

    }
    
    override func setupSubView() {
        super.setupSubView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.centerY.equalTo(imageView.snp.centerY)
        }
    
        button.addTarget(self, action:#selector(clickButton) , for: .touchUpInside)
        
        //只能是target的目标方法
        control.setTarget(target: self, action: LMStretchImageViewCell.testCurrying, event: .TouchUpInside)
    }
    
    func clickButton() {

        control.perfromActionFromControlEvent(controlEvent: .TouchUpInside)
    }
    
    func testCurrying(){
        print("点击柯里化按钮")
    }
    
}
