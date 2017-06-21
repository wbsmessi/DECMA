//
//  TopBarViewController.swift
//  DECMA
//
//  Created by 马志敏 on 2017/6/12.
//  Copyright © 2017年 DEC.MA. All rights reserved.
//

import UIKit

class TopBarViewController: UIViewController,DECTopBarViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        let barview = DECTopBarView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 50), value: ["苹果","香蕉","梨","橘子","西瓜","香蕉2","梨2","香蕉3","梨3"])
        barview.typedelegate = self
        self.view.addSubview(barview)
    }
    func DECTopBarItemSelected(barView:DECTopBarView,index:Int,selectedTitle:String){
        print(selectedTitle + "\(index)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
