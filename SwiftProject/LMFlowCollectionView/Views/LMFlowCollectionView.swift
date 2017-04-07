//
//  LMFlowCollectionView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit
import SwiftyJSON

class LMFlowCollectionView: UICollectionView {
    
    var flowDataArray : [LMFlowDataModel?]?
    
    
    init(frame: CGRect){
        //一定要用UICollectionViewLayout的子类 UICollectionViewFlowLayout 或自己继承UICollectionViewLayout重写方法
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(LMFlowCollectionViewCell.self, forCellWithReuseIdentifier: "LMFlowCollectionViewCell")
        addNotification()
    }
    
    deinit {
        removeNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionViewData(viewData:[LMFlowDataModel?])  {
    
        flowDataArray = viewData
        for item in flowDataArray! {
            guard let className = item?.className else {
                continue
            }
            
            self.register(NSClassFromString(className.getClassName()).self, forCellWithReuseIdentifier: className)
        }
        self.reloadData()
        
    }
}



extension LMFlowCollectionView : UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = flowDataArray else {
            return 0
        }
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = flowDataArray?[indexPath.row] else {
            return LMFlowCollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.className!, for: indexPath) as! LMFlowCollectionViewCell
        if let bgColor = model.backgroundColor {
            cell.backgroundColor =  UIColor.colorWithHexString(hex: bgColor)
        }
        
        cell.setDataModel(model: model)
        
        return cell
    }
    
}


extension LMFlowCollectionView : UICollectionViewDelegateFlowLayout {
    
    ///每个cell的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = flowDataArray?[indexPath.row] else {
            return CGSize.zero
        }
        return CGSize.init(width: Double(model.cellWidth!), height: Double(model.cellHeight!))
    }
    
    ///设置每组section的边界
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    ///cell的最小行间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    ///cell的最小列间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension LMFlowCollectionView {
    
    func addNotification(){
        NotificationCenter.default.addObserver(forName: kReloadRowNotification, object: nil, queue: OperationQueue.main) { (notification) in
            guard let userInfo = notification.userInfo ,
                let flowDataArray = self.flowDataArray else{
                return
            }
            
            let json = JSON.init(userInfo)
            
            var model = flowDataArray[json["row"].intValue]
            
            model?.cellHeight = json["height"].double
            
            self.flowDataArray?[json["row"].intValue] = model
            
            //self.reloadItems(at: [NSIndexPath.init(row: json["row"].intValue, section: 0) as IndexPath])
            self.reloadData()
        }
    }
    
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: kReloadRowNotification, object: nil)
    }
    
    
}
