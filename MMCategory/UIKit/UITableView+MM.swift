//
//  UITableView+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UITableView {
    public func mm_hiddenLine() {
    self.tableFooterView = UIView()
    }
    
    public func mm_registerCell(cls:AnyClass) {
        let clsName:String = "\(cls)"
        if Bundle.main.path(forResource: clsName, ofType: "nib") != nil {
            self.register(UINib.init(nibName: clsName, bundle: nil), forCellReuseIdentifier: clsName)
        }else {
            self.register(cls, forCellReuseIdentifier: clsName)
        }
        
    }
    
    public func mm_dequeueReusableCell<T> (cls:T.Type,indexPath :IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(cls)", for: indexPath)  as? T
            else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
}

extension UITableView {
    
    //更新tableView的简单方法
    
    func mm_update(callback:(_ tableIVew:UITableView)->Void) {
        beginUpdates()
        callback(self)
        endUpdates()
    }
    
    //滚动到指定位置
    func mm_scroll(to row:Int,inSection:Int, atPosition:UITableView.ScrollPosition = .none,animated:Bool = true) {
        let indexPath = IndexPath(row: row, section: inSection)
        scrollToRow(at: indexPath, at: atPosition, animated: animated)
    }
    
    //刷新指定行
    func mm_reload(row:Int,section:Int,animation:UITableView.RowAnimation = .none) {
        let indexPath = IndexPath(row: row, section: section)
        reloadRows(at: [indexPath], with: animation)
    }
}
