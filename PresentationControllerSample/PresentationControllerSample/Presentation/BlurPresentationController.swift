//
//  BlurPresentationController.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 04/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
public class BlurPresentationController: UIPresentationController {
    //TODO: make it configurable by writting setter method. Remove previous blur effect and add newly set value
    var blurEffectStyle: UIBlurEffectStyle
    weak public var presentationDelegate: BlurPresentationControllerDelegate?

    private lazy var effectContainerView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        return view
    }()

    private lazy var dimmingView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: self.blurEffectStyle)
        return UIVisualEffectView(effect: blurEffect)
    }()

    public init(presentedViewController: UIViewController, presentingViewController: UIViewController, blurEffectStyle: UIBlurEffectStyle) {
        self.blurEffectStyle = blurEffectStyle
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }

    public override func presentationTransitionWillBegin() {
        effectContainerView.frame = (containerView?.bounds)!
        dimmingView.frame = (containerView?.bounds)!

        effectContainerView.insertSubview(dimmingView, atIndex: 0)
        containerView?.insertSubview(effectContainerView, atIndex: 0)

        effectContainerView.alpha = 0.0

        if let coordinator = presentedViewController.transitionCoordinator() {
            coordinator.animateAlongsideTransition({ (viewControllerTransitionCoordinatorContext) -> Void in
                self.effectContainerView.alpha = 1.0
                }, completion: { (viewControllerTransitionCoordinatorContext) -> Void in
                    self.effectContainerView.alpha = 1.0
            })
        }
    }

    public override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator() {
            coordinator.animateAlongsideTransition({ (viewControllerTransitionCoordinatorContext) -> Void in
                self.effectContainerView.alpha = 0.0
                }, completion: { (viewControllerTransitionCoordinatorContext) -> Void in
                    self.effectContainerView.alpha = 0.0
            })
        }
    }

    public override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            presentationDelegate?.didDismissBlurPresentationController?(self)
        }
    }

    public override func containerViewWillLayoutSubviews() {
        let containerViewBounds = (containerView?.bounds)!
        effectContainerView.frame = containerViewBounds
        dimmingView.frame = containerViewBounds
        presentedView()!.frame = containerViewBounds
    }

    public override func shouldPresentInFullscreen() -> Bool {
       return true
    }

    public override func adaptivePresentationStyle() -> UIModalPresentationStyle {
        return .Custom
    }
}

@available(iOS 8.0, *)
//TODO: protocol extensions
@objc public protocol BlurPresentationControllerDelegate: NSObjectProtocol {
    optional func didDismissBlurPresentationController(presentationController: BlurPresentationController)
    
}
