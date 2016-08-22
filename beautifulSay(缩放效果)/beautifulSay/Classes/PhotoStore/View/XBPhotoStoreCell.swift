

//
//  XBPhotoStoreCell.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/18.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit
import SDWebImage
class XBPhotoStoreCell: UICollectionViewCell {
    // MARK:- 懒加载控件
    lazy var imageV :UIImageView = UIImageView()
    // MARK:-重写模型属性的set方法
    var shop :shopsItem? {
        didSet{
            // print(shop?.z_pic_url)
            // 1.校验shop是否有值
            guard let shop = shop else{
                return
            }
            // 2.获取小图片
            var smallImage = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(shop.q_pic_url)
            if smallImage == nil {
                smallImage = UIImage(named: "empty_picture")
            }
            // 3.根据image计算出来放大之后的frame
            imageV.frame = calculateFrameWithImage(smallImage)
            // 4.设置图片
            let url = NSURL(string: shop.z_pic_url)
            imageV.sd_setImageWithURL(url, placeholderImage: smallImage) { (image:UIImage! ,error: NSError!, type:SDImageCacheType, url:NSURL!) in
                self.imageV.frame = calculateFrameWithImage(image)
            }
        }
    }
    // MARK:- 重写init初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    // required : 如果一个构造函数前有required,那么重写了其他构造函数时,那么该构造函数也必须被重写
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
// MARK:-设置UI
extension XBPhotoStoreCell{
    func setUpUI(){
        // 图片添加到cell的contentView上
        self.contentView.addSubview(imageV)
    }
}

