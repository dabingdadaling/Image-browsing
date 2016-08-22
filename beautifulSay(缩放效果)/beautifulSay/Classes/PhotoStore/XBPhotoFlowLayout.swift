//
//  XBPhotoFlowLayout.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/16.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

class XBPhotoFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        itemSize = (collectionView?.bounds.size)!
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        
        
        
    }
}
