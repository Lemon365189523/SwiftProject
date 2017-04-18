//
//  LMCarouselView.swift
//  SwiftProject
//
//  Created by KADFWJ on 2017/4/18.
//  Copyright © 2017年 lemon. All rights reserved.
//

import Foundation

class LMCarouselView: UIScrollView ,UIScrollViewDelegate {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var duration : TimeInterval = 1{
        didSet(newValue) {
            if newValue >= 1 {
                self.startTimer()
            }
        }
    }
    var timer : Timer?
    var currentIV : UIImageView = {
        let iv = UIImageView.init()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleToFill
        iv.backgroundColor = UIColor.blue
        return iv
    }()//当前
    var lastIV : UIImageView = {
        let iv = UIImageView.init()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleToFill
        iv.backgroundColor = UIColor.brown
        return iv
    }()//前一个
    var nextIV : UIImageView = {
        let iv = UIImageView.init()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleToFill
        iv.backgroundColor = UIColor.orange
        return iv
    }()//下一个
    var imageUrls : [String]? {
        didSet {
            setupImageViews()
            setScrollView()
        }
        
    }
    ///MARK: 记录当前下标
    var currentIndex : Int = 0
    
    var autoScroll : Bool = false
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl.init()
//        control.backgroundColor = UIColor.white
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
        stopTimer()
    }
    
    public init(frame: CGRect, duration: TimeInterval, imageUrls:[String]) {
        super.init(frame: frame)
        if imageUrls.count < 1 {
            print("没有轮播图片")
            return
        }

        
        self.imageUrls = imageUrls
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setScrollView(){
        self.layoutIfNeeded()
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSize.init(width: 3 * frame.width, height: frame.height)
        self.delegate = self
        self.isPagingEnabled = true
        self.currentIV.frame = CGRect.init(x: frame.width, y: 0, width: frame.width, height: frame.height)
        self.lastIV.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        self.nextIV.frame = CGRect.init(x: 2 * frame.width, y: 0, width: frame.width, height: frame.height)
        self.contentOffset = CGPoint.init(x: frame.width, y: 0)
        self.addSubview(currentIV)
        self.addSubview(nextIV)
        self.addSubview(lastIV)
        if superview != nil {
            pageControl.frame = CGRect.init(x:  frame.width / 2 - 40, y: frame.height - 30, width: 80, height: 20)
            superview?.insertSubview(pageControl, aboveSubview: self)
            pageControl.numberOfPages = (imageUrls?.count)!
//            pageControl.addTarget(self, action: #selector(clickPageControl(pageControl:)), for: .valueChanged)
        }
    }
    
    func startTimer(){
        autoScroll = true
        if timer != nil {
            stopTimer()
        }
        //用timer的分类打破引用循环
        self.timer = Timer.lm_scheduledTimerWithTimeInterval(interval: duration, block: {[weak self] in
            if self == nil { return }
            let offsetX = Int((self?.contentOffset.x)! / (self?.screenWidth)!)
            let offsetFloat = CGFloat(offsetX) * (self?.screenWidth)!
            let newOffset = CGPoint(x: offsetFloat + (self?.frame.width)!, y: (self?.contentOffset.y)!)
            self?.setContentOffset(newOffset, animated: true)
        }, repeats: true)
    }
    
    func stopTimer(){
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func setupImageViews(){
        
        let nextIndex = getUrlArrayIndex(currentIndex: currentIndex + 1)
        let lastIndex = getUrlArrayIndex(currentIndex: currentIndex - 1)
        currentIV.image = UIImage.init(named: (imageUrls?[currentIndex])!)
        nextIV.image = UIImage.init(named: (imageUrls?[nextIndex])!)
        lastIV.image = UIImage.init(named: (imageUrls?[lastIndex])!)
        self.contentOffset = CGPoint(x: self.frame.width, y: 0)
    }
    
    func getUrlArrayIndex( currentIndex: Int) -> Int{
        if currentIndex == -1 {
            return (imageUrls?.count)! - 1
        }else if currentIndex == imageUrls?.count{
            return 0
        }else{
            return currentIndex
        }
    }
    
//    func clickPageControl(pageControl: UIPageControl){
//        currentIndex = pageControl.currentPage
//        setupImageViews()
//    }
    
}


extension LMCarouselView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //往右滑动过了currentIV的宽度后重设currentIndex
        if contentOffset.x >= 2 * frame.width {
            currentIndex = getUrlArrayIndex(currentIndex: currentIndex + 1)
            setupImageViews()
        }else if self.contentOffset.x <= 0 {
            currentIndex = getUrlArrayIndex(currentIndex: currentIndex - 1)
            setupImageViews()
        }
        pageControl.currentPage = currentIndex
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if autoScroll {
            startTimer()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll {
            stopTimer()
        }
    }
}

