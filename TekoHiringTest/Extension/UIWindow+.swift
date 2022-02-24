//
//  UIWindow.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit

func visibleViewController() -> UIViewController? {
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.visibleViewController
}

extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.visibleVC(vc: self.rootViewController)
    }

    static func visibleVC(vc: UIViewController?) -> UIViewController? {
        if let navigationViewController = vc as? UINavigationController {
            return UIWindow.visibleVC(vc: navigationViewController.visibleViewController)
        } else if let tabBarVC = vc as? UITabBarController {
            return UIWindow.visibleVC(vc: tabBarVC.selectedViewController)
        } else {
            if let presentedVC = vc?.presentedViewController {
                return UIWindow.visibleVC(vc: presentedVC)
            } else {
                return vc
            }
        }
    }
}
