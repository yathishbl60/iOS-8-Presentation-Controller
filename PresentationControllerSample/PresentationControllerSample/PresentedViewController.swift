//
//  PresentedViewController.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 05/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

class PresentedViewController: BlurViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
