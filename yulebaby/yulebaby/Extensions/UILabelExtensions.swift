//
//  UILabelExtensions.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// EZSE: Initialize Label with a font, color and alignment.
    public convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }
    
    /// EZSwiftExtensions
    public func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    /// EZSwiftExtensions
    public func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    /// EZSwiftExtensions
    public func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: h)).width
    }
    
    /// EZSwiftExtensions
    public func fitHeight() {
        self.h = getEstimatedHeight()
    }
    
    /// EZSwiftExtensions
    public func fitWidth() {
        self.w = getEstimatedWidth()
    }
    
    /// EZSwiftExtensions
    public func fitSize() {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
    
    /// EZSwiftExtensions (if duration set to 0 animate wont be)
    public func set(text _text: String?, duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
            self.text = _text
        }, completion: nil)
    }
}

