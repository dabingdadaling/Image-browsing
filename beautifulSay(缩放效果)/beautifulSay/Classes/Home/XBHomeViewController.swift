//
//  XBHomeViewController.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/15.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "homeCell"

class XBHomeViewController: UICollectionViewController {
    
    private lazy var animation :animatePhotoTrimite = animatePhotoTrimite()
    
  private lazy var shops :[shopsItem] = [shopsItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Swift中通过代码注册cell,Class变为self
    self.collectionView?.backgroundColor = UIColor.whiteColor()

       self.loadData(0)
    
}
    func loadData(offset : Int){
        // 创建请求管理者
         let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json"
        // 拼接请求参数
        let parameters = ["offset" : "\(offset)",
                          "limit" : "30",
                          "access_token" : "b92e0c6fd3ca919d3e7547d446d9a8c2"]
        // 发送请求
        NetworkTools.tools.requestData(.POST, urlString: urlString, parameters: parameters) { (result, error) in
            if error != nil{
                print(error)
            }
            guard let resultDict = result as? [String : NSObject] else{
                return
            }
            
            guard let array = resultDict["data"] as?[[String :NSObject]] else{
                return
            }
            // 字典数组
            for dict in array{
                self.shops.append(shopsItem(dict: dict))
            }
            
            // 刷新表格
            self.collectionView?.reloadData()
        }
    }
    // MARK:- UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.shops.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)as!XBShopCell
        // 传入模型
        cell.shop = self.shops[indexPath.row]
        // 当最后一个cell显示时上拉加载更多数据
        if indexPath.item == self.shops.count - 1 {
            self.loadData(self.shops.count)
        }
       // print(shop.q_pic_url,shop.z_pic_url)

        return cell
    }
    
    // MARK:- UICollectionViewDelegate
   override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let photoVc = XBPhotoController()
    // modal的转场类型
   // photoVc.modalTransitionStyle = .FlipHorizontal
    // 设置转场动画代理
    photoVc.transitioningDelegate = animation;
    photoVc.modalPresentationStyle = .Custom
    photoVc.shops = shops
    photoVc.indexPath = indexPath
    // 设置代理
    animation.disDelegate = photoVc
    animation.presentedDelegate = self
    animation.indexPath = indexPath
    presentViewController(photoVc, animated:true, completion: nil)
    
    }
    
}
// MARK:- 动画弹出协议-实现代理方法
extension XBHomeViewController :animationPresentedDelegate {
    func startCGRect(indexPath: NSIndexPath) -> CGRect {
        // 获取选中的cell
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else{
            return CGRectZero
        }
        // 设置cell的弹出位置的frame
        let startFrame = cell.frame
        // 转换坐标系
        let startRect = collectionView?.convertRect(startFrame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        return startRect!
    }
    func endCGRect(indexPath: NSIndexPath) -> CGRect {
        guard let endCell = collectionView?.cellForItemAtIndexPath(indexPath) as?XBShopCell else{
            return CGRectZero
        }
        // 获取图片
        guard let endImage = endCell.shopImageV.image else{
            return CGRectZero
        }
        
        // 获取放大后的frame
        return calculateFrameWithImage(endImage)
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        // 创建imageVIew
        let imageV = UIImageView()
        // 获取cell
        guard let imageCell = collectionView?.cellForItemAtIndexPath(indexPath)as? XBShopCell else{
            return imageV
        }
        // 获取图片
        guard let imageEnd = imageCell.shopImageV.image else{
            return imageV
        }
        imageV.image = imageEnd
        imageV.contentMode = .ScaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }
}


