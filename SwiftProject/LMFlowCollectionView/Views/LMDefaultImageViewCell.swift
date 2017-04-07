//
//  LMDefaultImageViewCell.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/6.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class LMDefaultImageViewCell: LMFlowCollectionViewCell {
    lazy var imageView: UIImageView = {
        let iv = UIImageView.init()
        return iv
    }()
    
    override func setDataModel(model: LMFlowDataModel) {
        super.setDataModel(model: model)
        guard let imageName = model.cellData?["imageName"]?.string  else {
            return
        }
        
        imageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageName)!))
        
    }
    
    override func setupSubView() {
        super.setupSubView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
}
