//
//  ViewController.swift
//  PresentationControllerSample
//
//  Created by Yatheesha on 04/11/15.
//  Copyright © 2015 Yatheesha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let segueID = segue.identifier
        let destinationViewController = segue.destinationViewController as? PresentedViewController
        if segueID == "DarkSegue" {
            destinationViewController?.blurEffectStyle = .Dark
        } else if segueID ==  "LightSegue" {
            destinationViewController?.blurEffectStyle = .Light
        }
    }
}

