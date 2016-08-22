//
//  UIButton-Extension.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/19.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

extension UIButton {
    // 在方法前加class表示是类方法,不加默认是对象方法
    class func creatBtn(title:String,bgColor:UIColor,fontSize:CGFloat)->(UIButton){
        let btn = UIButton()
        btn.backgroundColor = bgColor
        btn.setTitle(title, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        return btn
    }
    /*
     在extension扩充构造函数,只能扩充便利构造函数
     1> 必须在init前面加上convenience
     2> 必须在init方法中,调用self.init()
     */
   convenience init (title:String,bgColor:UIColor,fontSize:CGFloat){
        self.init()
    
    backgroundColor = bgColor
    setTitle(title, forState: .Normal)
    titleLabel?.font = UIFont.systemFontOfSize(fontSize)

    }
}