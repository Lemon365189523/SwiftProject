
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
    
    override func setDataModel(model: LMFlowDataModel) {
        super.setDataModel(model: model)
        guard let imageName = model.cellData?["imageName"]?.string  else {
            imageView.image = UIImage.init()
            return
        }
        imageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageName)!),  progressBlock: nil) { (image, error, CacheType, nil) in
            print(self.frame)
        }
        
    }
    
    override func setupSubView() {
        super.setupSubView()
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
}
