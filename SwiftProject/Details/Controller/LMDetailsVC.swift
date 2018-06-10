//
//  LMDetailsVC.swift
//  SwiftProject
//
//  Created by Macx on 2018/6/9.
//  Copyright © 2018年 lemon. All rights reserved.
//

import UIKit

class LMDetailsVC: UIViewController {
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let maxOffsetY : CGFloat = 150.0
    var currentScrollY : CGFloat = 0
    ////弹性和惯性动画
    var animator : UIDynamicAnimator?
    var decelerationBehavior : UIDynamicItemBehavior?
    var dynamicItem : LMDynamicItem?
    var springBehavior : UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //禁用掉自动设置的内边距
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
        
        self.mainScrollView.setNeedsLayout()
        self.mainScrollView.layoutIfNeeded()
        self.mainScrollView.contentSize = CGSize(width: width, height: mainScrollView.frame.height + maxOffsetY)

        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureRecognizerAction(recognizer:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        animator = UIDynamicAnimator.init(referenceView: self.view)
        dynamicItem = LMDynamicItem.init()
    }
    
    func setupUI(){
        mainScrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(width)
        }
        
        
        mainScrollView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(maxOffsetY + 44)
        }
        
        mainScrollView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height-64)
        }
    }

    
    deinit {
        print("销毁")
    }
    
    lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.isScrollEnabled = false
        self.view.addSubview(view)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .red
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var headerView: LMHeaderView  = {
        let view = LMHeaderView()
        view.backgroundColor = .green
        return view
    }()

}

extension LMDetailsVC : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = String(indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}

extension LMDetailsVC : UIGestureRecognizerDelegate {
    //通过禁用tableView与mainScrollView的手势，然后用pan手势来mainScrollView和tableView的contentOffSet做改变
    //滑动手势触发方法
    @objc fileprivate func panGestureRecognizerAction(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            currentScrollY = self.mainScrollView.contentOffset.y
            animator?.removeAllBehaviors()
        case .changed:
            let currentY = recognizer.translation(in: self.view).y
            //控制那个scrollView滚动
            controlScrollForVertical(detal: currentY, state: .changed)
        case .ended:
            self.dynamicItem?.center = self.view.bounds.origin
            //手势结束时移除弹性动画
            springBehavior = nil
            //velocity是在手势结束的时候获取的竖直方向的手势速度
            let velocity = recognizer.velocity(in: self.view)
            //滑动惯性动画
            let inertialBehavior = UIDynamicItemBehavior.init(items: [dynamicItem!])
            inertialBehavior.addLinearVelocity(CGPoint(x: 0, y: velocity.y), for: dynamicItem!)
            // 通过尝试取2.0比较像系统的效果
            inertialBehavior.resistance = 2.0
            var lasetCenter = CGPoint.zero
            inertialBehavior.action = { [weak self] in
                //得到每次移动的距离
                let currentY = (self?.dynamicItem?.center.y)! - lasetCenter.y
                //添加弹性动画
                self?.controlScrollForVertical(detal: currentY, state: .ended)
                lasetCenter = (self!.dynamicItem?.center)!
                
            }
            
            self.animator?.addBehavior(inertialBehavior)
            self.decelerationBehavior = inertialBehavior
            
        default:
            break

        }
        
        //保证每次只是移动的距离，不是从头一直移动的距离
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    //弹性距离
    fileprivate func rubberBandDistance(offset : CGFloat ,dimension : CGFloat) -> CGFloat{
        let constant : CGFloat = 0.55
        let result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
        return offset < 0.0 ? -result : result;
    }
    
    //控制上下滚动
    fileprivate func controlScrollForVertical(detal: CGFloat, state:UIGestureRecognizerState ){
        //判断是主ScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
        if mainScrollView.contentOffset.y >= maxOffsetY - 64.0{
//            print("超过maxOffsetY>>>>>>")
            var offsetY = tableView.contentOffset.y - detal
            if offsetY < 0 {
                //当子ScrollView的contentOffset小于0之后就不再移动子ScrollView，而要移动主ScrollView
                offsetY = 0
                self.mainScrollView.contentOffset = CGPoint(x: self.mainScrollView.frame.origin.x, y: self.mainScrollView.contentOffset.y - detal)
                
            }else if offsetY > (self.tableView.contentSize.height - self.tableView.frame.size.height){
                offsetY = self.tableView.contentOffset.y - rubberBandDistance(offset: detal, dimension: height)
            }
            
            self.tableView.contentOffset = CGPoint(x:0,y: offsetY);
        }else{
            var mainOffsetY = self.mainScrollView.contentOffset.y - detal;
            if mainOffsetY < 0 {
                mainOffsetY = self.mainScrollView.contentOffset.y - rubberBandDistance(offset: detal, dimension: height);
            }else if mainOffsetY > maxOffsetY {
                mainOffsetY = maxOffsetY
            }
//            print("<<<<<<没有超过maxOffsetY:\(mainOffsetY)")

            self.mainScrollView.contentOffset = CGPoint(x: mainScrollView.frame.origin.x, y: mainOffsetY)
            
            if mainOffsetY == 0{
                tableView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
        
        //动画效果
        addBehavior()
    }
    
    func addBehavior() {
        //拖动超出了界限
        let outsideFrame = mainScrollView.contentOffset.y < 0 || tableView.contentOffset.y > (tableView.contentSize.height - tableView.frame.height)
        if outsideFrame && (self.decelerationBehavior != nil && springBehavior == nil) {
            var target = CGPoint.zero
            var isMain = false
            
            if mainScrollView.contentOffset.y < 0 {
                dynamicItem?.center = mainScrollView.contentOffset
                isMain = true
            }else if (tableView.contentOffset.y > (tableView.contentSize.height - tableView.frame.height)) {
                dynamicItem?.center = tableView.contentOffset
                
                target = CGPoint(x: tableView.contentOffset.x, y: tableView.contentSize.height - tableView.frame.height)
                isMain = false
            }
            print("添加动画:\(isMain)")
            animator?.removeBehavior(decelerationBehavior!)
            let springBehavior = UIAttachmentBehavior.init(item: dynamicItem!, attachedToAnchor: target)
            springBehavior.length = 0
            springBehavior.damping = 1
            springBehavior.frequency = 2
            springBehavior.action = { [weak self] in
                if isMain {
                    self!.mainScrollView.contentOffset = self!.dynamicItem!.center
                    if self?.mainScrollView.contentOffset.y == 0 {
                        self?.tableView.contentOffset = CGPoint(x: 0, y: 0)
                    }
                }else{
                    self!.tableView.contentOffset = self!.dynamicItem!.center
                }
            }
            self.animator?.addBehavior(springBehavior)
            self.springBehavior = springBehavior
        }

    }
    
    //是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //如果再套一个横向滑动的scrollView需要下面判断
//        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
//            let recognizer = gestureRecognizer as! UIPanGestureRecognizer
//            let currentY = recognizer.translation(in: self.view).y
//            if currentY == 0.0 {
//                print("手势代理触发: \(currentY)")
//                return true
//            }
//        }
        
        return false
    }
    
}
