//
//  animatePhotoTrimite.swift
//  beautifulSay
//
//  Created by xiebin on 16/8/19.
//  Copyright © 2016年 xiebin. All rights reserved.
//

import UIKit
// MARK:-弹出图片协议
protocol animationPresentedDelegate :class {
    func startCGRect(indexPath:NSIndexPath) -> CGRect
    func endCGRect(indexPath:NSIndexPath) -> CGRect
    func imageView(indexPath:NSIndexPath) -> UIImageView
}
// MARK:-图片缩放消失协议
protocol dismissedDelegate : class {
    func getCurrentIndexPath() -> NSIndexPath
    func getCurrentImageView() -> UIImageView
}

class animatePhotoTrimite: NSObject {

    // 定义属性
    var ispresented :Bool = true
    var indexPath : NSIndexPath?
    // 设置代理
   weak var presentedDelegate :animationPresentedDelegate?
   weak var disDelegate :dismissedDelegate?
    
}

// MARK:-实现转场动画
extension animatePhotoTrimite : UIViewControllerTransitioningDelegate{
    // 为弹出的控制器做转场动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        ispresented = true
        return self
    }
    // 为消失的控制器做转场动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        ispresented = false
        return self
    }
}

extension animatePhotoTrimite: UIViewControllerAnimatedTransitioning{
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 1.0
    }
    // transitionContext : 转场上下文
    // 作用 : 可以通过上下文获取到弹出的View和消失的View
    // UITransitionContextFromViewKey : 获取消失的View
    // UITransitionContextToViewKey : 获取弹出的View
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        if ispresented {
            
            // 判断代理对象是否有值
            guard let presDelegate = presentedDelegate else{
                return
            }
            
            guard let indexP = indexPath else{
                return
            }
            
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            transitionContext.containerView()?.addSubview(presentView)
            presentView.alpha = 0.0
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            
            // 获取UIImageView
            let imageV :UIImageView = presDelegate.imageView(indexP)
            transitionContext.containerView()?.addSubview(imageV)
            // 获取图片放大起始位置
            let startCGRect :CGRect = presDelegate.startCGRect(indexP)
            imageV.frame = startCGRect
            
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            // 获取图片放大终点位置
            let endCGRect :CGRect = presDelegate.endCGRect(indexP)
            imageV.frame = endCGRect
            }) { (isfinished:Bool) in
                imageV.removeFromSuperview()
                presentView.alpha = 1.0
                transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                transitionContext.completeTransition(isfinished)
            }
        }else{
            guard let dismiDelegate = disDelegate else{
                return
            }
            
            guard let presDelegate = presentedDelegate else{
                return
            }
            
            let dismissedView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            dismissedView.removeFromSuperview()
            // 获取最新的indexPath
            let lastIndexPath = dismiDelegate.getCurrentIndexPath()
            // 获取图片对象
            let imageView = dismiDelegate.getCurrentImageView()
             transitionContext.containerView()?.addSubview(imageView)
            
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            // 获取缩放的终点位置
            let dismEndRect = presDelegate.startCGRect(lastIndexPath)
            if dismEndRect == CGRectZero{
                imageView.alpha = 0.0
            }else{
                
                imageView.frame = dismEndRect
            }
                }, completion: { (isfinished:Bool) in
                    transitionContext.completeTransition(isfinished)
            })
        }
        
    }
}
