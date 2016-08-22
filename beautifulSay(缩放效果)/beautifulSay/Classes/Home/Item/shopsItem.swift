//
//  shopsItem.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/16.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

class shopsItem: NSObject {
    var q_pic_url : String = ""
    var z_pic_url : String = ""
    
     init(dict: [String : NSObject]) {
        super.init()
        // 字典转模型
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    

}
