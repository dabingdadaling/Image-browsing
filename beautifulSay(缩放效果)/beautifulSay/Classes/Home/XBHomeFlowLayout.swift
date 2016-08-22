//
//  XBHomeFlowLayout.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/15.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

class XBHomeFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        let clos : CGFloat = 3
        let margin : CGFloat = 10
        
        let itemWH = (UIScreen.mainScreen().bounds.width - (clos + 1) * margin) / clos
        itemSize = CGSizeMake(itemWH, itemWH)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(64 + margin, margin, margin, margin)
        
        
        
    }

}
