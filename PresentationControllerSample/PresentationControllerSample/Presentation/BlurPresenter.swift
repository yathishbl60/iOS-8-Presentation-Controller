//
//  BlurPresentor.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 04/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class BlurPresenter: NSObject, UIViewControllerTransitioningDelegate {

    var blurEffectStyle = UIBlurEffectStyle.Dark {
        didSet {
            if animationController != nil {
                animationController.blurEffectStyle = blurEffectStyle
            }
        }
    }
    
    private var animationController: BlurPresentationController!

    override init() {
        blurEffectStyle = .Dark
        super.init()
    }

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        if animationController == nil {
            animationController = BlurPresentationController(presentedViewController: presented, presentingViewController: presenting, blurEffectStyle: blurEffectStyle)
            animationController.presentationDelegate = self
        }
        return animationController
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = BlurTransitioning()
        transition.isPresentation = true

        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = BlurTransitioning()
        transition.isPresentation = false

        return transition
    }
}

extension BlurPresenter: BlurPresentationControllerDelegate {
    func didDismissBlurPresentationController(presentationController: BlurPresentationController) {
        animationController = nil
    }
}

