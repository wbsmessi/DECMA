//
//  DECGuidePageViewController.swift
//  DECMA
//
//  Created by 马志敏 on 2017/6/5.
//  Copyright © 2017年 DEC.MA. All rights reserved.
//

import UIKit

class DECGuidePageViewController: UIViewController,UIScrollViewDelegate {
    
    var imgCount:Int = 0
    var imgArr = ["boot-page1","boot-page2","boot-page3","boot-page4"]
    let app_width = UIScreen.main.bounds.width
    let app_height = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        creatView()
    }
    var startBtn:UIButton!
    func creatView(){
        imgCount = imgArr.count
        self.automaticallyAdjustsScrollViewInsets = false
        let scroll = UIScrollView()
        scroll.delegate=self
        scroll.frame = self.view.frame
        scroll.bounces=false
        scroll.isPagingEnabled=true
        scroll.showsVerticalScrollIndicator=false
        scroll.showsHorizontalScrollIndicator=false
        scroll.contentSize = CGSize(width: app_width * CGFloat(imgCount), height: app_height)
        self.view.addSubview(scroll)
        
        startBtn = UIButton()
        startBtn.frame = CGRect(x: app_width * 0.35, y: app_height * 0.83, width: app_width * 0.3, height: app_height * 0.05)
        startBtn.setTitle("立即体验", for: .normal)
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        startBtn.isHidden = true
        startBtn.layer.cornerRadius = 20
        startBtn.addTarget(self, action: #selector(turnToHomePage), for: .touchUpInside)
//        startBtn.setTitleColor(UIColor.red, for: .normal)
//        startBtn.backgroundColor = UIColor.clear
        self.view.addSubview(startBtn)
        
        for i in 0..<imgCount{
            let img = UIImageView()
            img.frame = CGRect(x: app_width * CGFloat(i), y: 0, width: app_width, height: app_height)
            img.image = UIImage(named: imgArr[i])
            scroll.addSubview(img)
        }
    }
    func turnToHomePage(){
        self.dismiss(animated: true) { 
            // can do something when back to page
        }
//        self.dismiss(animated: true, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        print(scrollView.contentOffset.x)
        if scrollView.contentOffset.x >= app_width * CGFloat(imgCount-1){
            //            最后一张图
            startBtn.isHidden = false
        }else{
            startBtn.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
