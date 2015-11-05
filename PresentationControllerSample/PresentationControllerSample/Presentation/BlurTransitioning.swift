//
//  BlurTransitioning.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 04/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class BlurTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresentation = false

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)

        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)

        let containerView = transitionContext.containerView()

        if isPresentation {
            containerView?.addSubview(toView!)
        }

        let animatingViewController = isPresentation ? toViewController : fromViewController
        let animatingView = isPresentation ? toView : fromView

        let onScreenFrame = transitionContext.finalFrameForViewController(animatingViewController!)
        let  offScreenFrame = CGRectOffset(onScreenFrame, 0.0, onScreenFrame.size.height)

        let initialFrame = isPresentation ? offScreenFrame : onScreenFrame
        let finalFrame = isPresentation ? onScreenFrame : offScreenFrame

        animatingView?.frame = initialFrame

        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: [.AllowUserInteraction, .BeginFromCurrentState], animations: { () -> Void in

            animatingView?.frame = finalFrame

            }) { (success) -> Void in
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                
                transitionContext.completeTransition(true)
        }
    }
}
