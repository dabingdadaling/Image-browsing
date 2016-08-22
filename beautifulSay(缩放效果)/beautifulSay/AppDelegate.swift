//
//  AppDelegate.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/15.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        return true
    }
}
    
    // MARK:- 根据Image计算放大之后的frame
    func calculateFrameWithImage(image :UIImage) -> CGRect {
            // 1.取出屏幕的宽度和高度
            let ScreenW = UIScreen.mainScreen().bounds.width
            let ScreenH = UIScreen.mainScreen().bounds.height
            
            // 2.计算imageView的frame
            let imageW = ScreenW
            let imageH = ScreenW / image.size.width * image.size.height
            let imageX :CGFloat = 0
            let imageY :CGFloat = (ScreenH - imageH) * 0.5
            
            return CGRect(x: imageX, y: imageY, width:imageW, height: imageH)
        }
