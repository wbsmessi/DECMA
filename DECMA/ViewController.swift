//
//  ViewController.swift
//  DECMA
//
//  Created by 马志敏 on 2017/6/5.
//  Copyright © 2017年 DEC.MA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let titleArr:[String] = ["顶部导航（可滑动）"]
    var firstStart:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTable()
        if firstStart{
            needLoadGuidePage()
        }
    }
    func initTable(){
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 20)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 45
        table.tableFooterView = UIView()
        self.view.addSubview(table)
    }
    
    func needLoadGuidePage(){
        let vc = DECGuidePageViewController()
//        vc.imgArr = []
        //有tabbar的情况
//        vc.hidesBottomBarWhenPushed = true
        //翻转效果
        vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        //跳转，动画设置false
        let keyrootview = UIApplication.shared.keyWindow?.rootViewController
//        delegate!
        //避免警告
        DispatchQueue.main.async {
            keyrootview?.present(vc, animated: false, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        let title = UILabel()
        title.frame = CGRect(x: 20, y: 0, width: 200, height: 45)
        title.text = titleArr[indexPath.row]
        cell.contentView.addSubview(title)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(TopBarViewController(), animated: true)
        default:
            _=""
        }
    }
}

