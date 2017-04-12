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
    
    
    var flowServer : LMFlowDataServer?
    
    let layout = UICollectionViewFlowLayout.init()
    
    init(frame: CGRect){
        //一定要用UICoICollectionViewLayout的子类 UICollectionViewFlowLayout 或自己继承UICollectionViewLayout重写方法
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
    
    //设置数据，每个flowView有一个FlowServer做数据处理
    func setCollectionflowServer(flowServer:LMFlowDataServer)  {
        self.flowServer = flowServer
        for  item in (self.flowServer?.dataArray)! {
            guard let className = item?.className else {
                continue
            }
            //防止名称错误的问题 如果名称错误和不存在的Class 创建LMFlowCollectionViewCell类型的cell
            guard let nsClass = NSClassFromString(className.getClassName()) else {
                self.register(LMFlowCollectionViewCell.self, forCellWithReuseIdentifier: (item?.className)!)
                continue
            }
            if (nsClass.isSubclass(of: LMFlowCollectionViewCell.self)) {
               self.register(NSClassFromString(className.getClassName()).self, forCellWithReuseIdentifier: className)
            }else{
                self.register(LMFlowCollectionViewCell.self, forCellWithReuseIdentifier: (item?.className)!)
            }
            
        }
        
        //调用主线程要用这个方法
        DispatchQueue.main.async(execute: {
            self.reloadData()

        })
    }
    
    
    func updateCellData(cellId: String, cellData:Dictionary<String, JSON>){
        flowServer?.insertCellData(cellData: cellData, cellId: cellId)
        guard let index = flowServer?.getIndex(cellId: cellId) else {return}
        DispatchQueue.main.async(execute: {
            UIView.performWithoutAnimation({
                self.reloadItems(at: [NSIndexPath.init(row: index, section: 0) as IndexPath])
            })
        })
    }
    
}



extension LMFlowCollectionView : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = self.flowServer?.dataArray else {
            return 0
        }
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = self.flowServer?.dataArray[indexPath.row] else {
            return LMFlowCollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.className!, for: indexPath) as! LMFlowCollectionViewCell
        if let bgColor = model.backgroundColor {
            cell.backgroundColor =  UIColor.colorWithHexString(hex: bgColor)
        }
        
        cell.setDataModel(model: model,flowServer: flowServer!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = self.flowServer?.dataArray[indexPath.row] ,
            let targetAction = model.clickAction  else {return}
        print(targetAction)
        
    }
    
}


extension LMFlowCollectionView : UICollectionViewDelegateFlowLayout {
    
    ///每个cell的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = self.flowServer?.dataArray[indexPath.row] else {
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
                let flowDataArray = self.flowServer?.dataArray else{
                return
            }
            
            let json = JSON.init(userInfo)
            
            var model = flowDataArray[json["row"].intValue]
            
            if model?.needSetData == false {
                return
            }
            
            model?.cellHeight = json["height"].double
            
            model?.needSetData = false
                        
            self.flowServer?.updateModel(index: json["row"].intValue, model: model)
            
            DispatchQueue.main.async(execute: {
                //self.reloadData()
                UIView.performWithoutAnimation({
                    self.reloadItems(at: [NSIndexPath.init(row: json["row"].intValue, section: 0) as IndexPath])
                })
            })
            
        }
    }
    
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: kReloadRowNotification, object: nil)
    }
    
    
}
