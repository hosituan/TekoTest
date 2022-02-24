//
//  UIView+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit

//MARK: Set action to UIView
private var actionKey: Void?
extension UIView {
    func setAction(action: (() -> ())?) {
        self.isUserInteractionEnabled = true
        self.action = action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.addGestureRecognizer(tapGesture)
    }

    private var action: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func pressed() {
        action?()
    }
}

extension Array where Element: UIView {
    func setAction(action: (() -> ())?) {
        for view in self {
            view.setAction(action: action)
        }
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    @discardableResult
    public func addSubViews(_ subviews: [UIView]) -> UIView {
        subviews.forEach { addSubview($0) }
        return self
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: (layer.borderColor ?? UIColor.clear.cgColor))
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
