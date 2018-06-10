//
//  LMTabBarController.swift
//  SwiftProject
//
//  Created by Macx on 2017/3/9.
//  Copyright © 2017年 lemon. All rights reserved.
//

import UIKit

class LMTabBarController: UITabBarController {
    
    lazy var bgImageView = {() -> UIImageView in
        let iv = UIImageView()
        iv.image = UIImage(named:"ddd")
        return iv
    }
    
    //tabbarItem正常状态下的图片数组
    lazy var normalImageArray: [UIImage] = {
        var tempArray : [UIImage] = [UIImage]()
        tempArray.append(UIImage(named: "nav_bg_1_1")!)
        tempArray.append(UIImage(named: "nav_bg_2_1")!)
        tempArray.append(UIImage(named: "nav_bg_3_1")!)
        tempArray.append(UIImage(named: "nav_bg_4_1")!)
        tempArray.append(UIImage(named: "nav_bg_5_1")!)
        return tempArray
    }()
    
    lazy var selectImageArray:[UIImage] = {
        var tempArray: [UIImage] = [UIImage]()
        tempArray.append(UIImage(named: "nav_bg_1_2")!)
        tempArray.append(UIImage(named: "nav_bg_2_2")!)
        tempArray.append(UIImage(named: "nav_bg_3_2")!)
        tempArray.append(UIImage(named: "nav_bg_4_2")!)
        tempArray.append(UIImage(named: "nav_bg_5_2")!)
        return tempArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatTabBar()
        
    }
    
}


extension LMTabBarController {
    
    func creatTabBar(){
        
        let home = LMHomeViewController()
        let homeNavi = UINavigationController.init(rootViewController: home)
        setTabBarItem(vc: homeNavi,title: "首页", normalImage:normalImageArray[0],selectImage: selectImageArray[0] )
        
        let vc2 = LMBasicViewController()
        let navi2 = UINavigationController.init(rootViewController: vc2)
        self.setTabBarItem(vc: navi2,title: "分类", normalImage:normalImageArray[1],selectImage: selectImageArray[1] )
        
//        let vc3 = LMBasicViewController()
//        let navi3 = UINavigationController.init(rootViewController: vc3)
//        setTabBarItem(vc: navi3,title: "咨询", normalImage:normalImageArray[2],selectImage: selectImageArray[2] )
        
        let vc4 = LMBasicViewController()
        let navi4 = UINavigationController.init(rootViewController: vc4)
        setTabBarItem(vc: navi4,title: "购物车", normalImage:normalImageArray[3],selectImage: selectImageArray[3] )
        
        let vc5 = LMBasicViewController()
        let navi5 = UINavigationController.init(rootViewController: vc5)
        setTabBarItem(vc: navi5,title: "我的", normalImage:normalImageArray[4],selectImage: selectImageArray[4] )
        
        let navArray = [homeNavi, navi2, navi4, navi5]
       
        
        //改变tabBar选中标题颜色
//        tabBar.tintColor = UIColor.green
        let tabbar = LMTabBar()
        tabbar.tabbarDelegate = self
        tabbar.tabBarDataSource = self
        self.setValue(tabbar, forKey: "tabBar")
        viewControllers = navArray
    }
    
    func setTabBarItem(vc: UIViewController,title: String , normalImage: UIImage, selectImage: UIImage)  {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = normalImage.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectImage.withRenderingMode(.alwaysOriginal)
        
    }
}

extension LMTabBarController: LMTabBarDelegate ,LMTabBarDataSource {
    func customBarItem(_ tabBar: LMTabBar) -> UIView {
        let view = UIView()
        let img = UIImageView()
        let title = UILabel()
        view.addSubview(img)
        view.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
        }
        img.snp.makeConstraints { (make) in
            make.bottom.equalTo(title.snp.top)
            make.height.width.equalTo(70)
            make.top.equalTo(0)
            make.centerX.equalToSuperview()
        }
        title.text = "自定义"
        title.textAlignment = .center
        img.backgroundColor = .red
        view.backgroundColor = .yellow
        return view
    }
    
    func selectCustomBar(_ tabBar: LMTabBar) {
        print("点击了自定义按钮")
    }
    
    func numberOfCustomBarItem(_ tabBar: LMTabBar) -> Int {
        return 1
    }
}
