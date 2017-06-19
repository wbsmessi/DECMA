//
//  DECTopBar.swift
//  DECMA
//
//  Created by 马志敏 on 2017/6/5.
//  Copyright © 2017年 DEC.MA. All rights reserved.
//

import UIKit

protocol DECTopBarViewDelegate {
    func DECTopBarItemSelected(barView:DECTopBarView,index:Int,selectedTitle:String)
}

class DECTopBarView: UIView {

    var typeValue:[String]!
    var typedelegate:DECTopBarViewDelegate?
    var item_width:CGFloat = 100
    //未选中的字体颜色
    var defaultColor = UIColor.black
//    选中的字体颜色
    var selectedColor = UIColor.blue
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    let bgscrollView = UIScrollView()
    init(frame: CGRect,value:[String]) {
        super.init(frame: frame)
        self.typeValue = value
        let wid = self.frame.width/CGFloat(value.count)
        
        self.item_width = wid > 100 ? wid:100
        
        bgscrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        bgscrollView.backgroundColor = UIColor.white
        bgscrollView.contentSize = CGSize(width: CGFloat(typeValue.count) * item_width, height: bgscrollView.frame.height)
        bgscrollView.showsHorizontalScrollIndicator = false
        bgscrollView.showsVerticalScrollIndicator = false
        self.addSubview(bgscrollView)
        let bottomline = CALayer()
        bottomline.frame = CGRect(x: 0, y: bgscrollView.frame.height - 1, width: bgscrollView.frame.width, height: 1)
        bottomline.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomline)
        self.creatView(array: typeValue)
    }
    func creatView(array: [String]){
        //        self.frame.width
        self.backgroundColor = UIColor.white
        
        initWithArray(array: array)
    }
    
    func initWithArray(array: [String]) {
        for i in 0..<array.count{
            creatItem(index: i, title: array[i])
        }
    }
    
    func creatItem(index:Int,title:String){
        let btn = UIButton()
        //防止冲突，设置大些
        btn.tag = index + 1000
        btn.frame = CGRect(x: CGFloat(index) * item_width, y: 0, width: item_width, height: self.frame.height)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(defaultColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: 5)
//        btn.backgroundColor = UIColor.red
        bgscrollView.addSubview(btn)
        btn.addTarget(self, action: #selector(choseItem), for: .touchUpInside)
        
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: btn.frame.width/4, y: btn.frame.height - 7, width: btn.frame.width/2, height: 2)
        bottomBorder.backgroundColor = UIColor.clear.cgColor
        btn.layer.addSublayer(bottomBorder)
        
        //设置第一个item选中
        if index == 0{
            btn.setTitleColor(selectedColor, for: .normal)
            bottomBorder.backgroundColor = selectedColor.cgColor
            self.selectedBtn = btn
        }
    }
    var selectedBtn:UIButton!
    func choseItem(btn:UIButton){
        let currentTag:Int = btn.tag - 1000
        DispatchQueue.main.async {
            //上一个还原
            self.selectedBtn.setTitleColor(self.defaultColor, for: .normal)
            self.selectedBtn.layer.sublayers?.last?.backgroundColor = UIColor.clear.cgColor
            //标记新的item
            btn.setTitleColor(self.selectedColor, for: .normal)
            btn.layer.sublayers?.last?.backgroundColor = self.selectedColor.cgColor
            
            
            let title = self.typeValue[currentTag]
            self.typedelegate?.DECTopBarItemSelected(barView: self, index: currentTag,selectedTitle:title)
            self.selectedBtn = btn
            //做滚动
            let current_x = self.item_width * CGFloat(currentTag)
            if current_x >= self.frame.width/2{
                
                if current_x + self.frame.width/2 > CGFloat(self.typeValue.count) * self.item_width{
                    self.bgscrollView.setContentOffset(CGPoint(x: CGFloat(self.typeValue.count) * self.item_width - self.frame.width, y: 0), animated: true)
                }else{
                    self.bgscrollView.setContentOffset(CGPoint(x: current_x - self.frame.width/2, y: 0), animated: true)
                }
            }else{
                self.bgscrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
