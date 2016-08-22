//
//  XBPhotoController.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/16.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit
private let ID :String = "cellID"
class XBPhotoController: UIViewController {

    private lazy var collectionView :UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: XBPhotoFlowLayout())
    var shops : [shopsItem]?
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置图片浏览分页间距
        view.frame.size.width += 10
        self.view.backgroundColor = UIColor.purpleColor()
        self.setUpUI()
        // 设置选中的图片
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: true)
    }
}
// Mark:- 设置UI
extension XBPhotoController{
    func setUpUI() {
        self.setUpCollectionView()
        self.setUpBtn()
    }
    // 创建CollectionView
    func setUpCollectionView(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.registerClass(XBPhotoStoreCell.self, forCellWithReuseIdentifier: ID)
        collectionView.frame = view.bounds
        self.view.addSubview(collectionView)
    }
    
    func setUpBtn(){
        let btn : UIButton = UIButton(type: .Custom)
        btn.setTitle("关 闭", forState: .Normal)
        btn.backgroundColor = UIColor.orangeColor()
        let margin : CGFloat = 10
        let btnX :CGFloat = 10
        let btnH :CGFloat = 30
        let btnW :CGFloat = 90
        let btnY = UIScreen.mainScreen().bounds.height - btnH - margin
        btn.frame = CGRectMake(btnX,btnY, btnW, btnH)
        btn.addTarget(self, action:#selector(XBPhotoController.btnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        
        let saveBtn : UIButton = UIButton(type: .Custom)
        saveBtn.setTitle("保 存", forState: .Normal)
        saveBtn.backgroundColor = UIColor.redColor()
        let saveBtnX = UIScreen.mainScreen().bounds.width - btnW - margin
        let saveBtnY = btnY
        saveBtn.frame = CGRectMake(saveBtnX, saveBtnY, btnW, btnH)
        
        saveBtn.addTarget(self, action: #selector(XBPhotoController.saveClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(saveBtn)
        
    }
    
 @objc private func btnClick(){
         dismissViewControllerAnimated(true, completion: nil)
    }
    
  @objc private func saveClick(){
        // 1.获取当前正在显示的cell
    let cell = collectionView.visibleCells()[0] as! XBPhotoStoreCell
    // 拿到cell显示的图片
    guard let image = cell.imageV.image else{
        return
    }
        // 2.保存到系统相册
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

}
// MARK:- UICollectionViewDataSource方法
extension XBPhotoController : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ?? : 系统先判断前面的可选链是否有值, 如果有值,解包并且获取对应的类型. 如果没有值直接取后面的值
        return shops?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! XBPhotoStoreCell
        let shop = shops![indexPath.item]
        cell.shop = shop
        
       // cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blueColor():UIColor.greenColor()
        return cell
        
    }
    
}

extension XBPhotoController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        btnClick()
    }
}

extension XBPhotoController:dismissedDelegate {
    func getCurrentIndexPath() -> NSIndexPath {
        // 获取屏幕显示的cell
        let currentCell = collectionView.visibleCells()[0]
        // 获取当前屏幕显示的cell的indexpath
        let indexPh = collectionView.indexPathForCell(currentCell)!
        
        return indexPh
        
    }
    
    func getCurrentImageView() -> UIImageView {
        // 1.创建UIImageView
        let imageView = UIImageView()
        // 2.设置imageView属性
        // 获取屏幕显示的cell
        let cell = collectionView.visibleCells()[0] as! XBPhotoStoreCell
        imageView.image = cell.imageV.image
        imageView.frame = calculateFrameWithImage(imageView.image!)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}
