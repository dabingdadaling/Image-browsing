//
//  XBShopCell.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/16.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit
import SDWebImage
class XBShopCell: UICollectionViewCell {
    
    @IBOutlet weak var shopImageV: UIImageView!
    
    var shop : shopsItem? {
        didSet{
            guard let shop = shop else{
                return
            }
            let url = NSURL(string: shop.q_pic_url)
            
            self.shopImageV .sd_setImageWithURL(url, placeholderImage: UIImage.init(named: "empty_picture"))
        }
    }
    
}
