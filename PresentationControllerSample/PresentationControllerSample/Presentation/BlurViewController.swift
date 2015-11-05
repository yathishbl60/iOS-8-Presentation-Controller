//
//  BlurViewController.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 05/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class BlurViewController: UIViewController {

    var blurEffectStyle = UIBlurEffectStyle.Dark {
        didSet {
            presenter.blurEffectStyle = blurEffectStyle
        }
    }

    private var presenter = BlurPresenter()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commontInit()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commontInit()
    }

    private func commontInit() {
        modalPresentationStyle = .Custom
        presenter.blurEffectStyle = blurEffectStyle
        transitioningDelegate = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
    }

}
