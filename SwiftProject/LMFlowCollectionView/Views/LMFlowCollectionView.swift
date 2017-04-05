//
//  LMFlowCollectionView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/3/31.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMFlowCollectionView: UICollectionView {
    
    var flowDataArray : [LMFlowDataModel?]?
    
    
    init(frame: CGRect){
        //一定要用UICollectionViewLayout的子类 UICollectionViewFlowLayout 或自己继承UICollectionViewLayout重写方法
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(LMFlowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionViewData(viewData:[LMFlowDataModel?])  {
        
        flowDataArray = viewData
        
        self.reloadData()
    
        print("\(viewData)")
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
        let cell : LMFlowCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LMFlowCollectionViewCell 
        guard let cellData = flowDataArray?[indexPath.row]?.cellData else {
            return cell
        }
        cell.setDataModel(model: cellData)
        return cell
    }
    
}


extension LMFlowCollectionView : UICollectionViewDelegateFlowLayout {
    
    ///每个cell的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }
    
    ///设置每组section的边界
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    ///cell的最小行间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    ///cell的最小列间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
