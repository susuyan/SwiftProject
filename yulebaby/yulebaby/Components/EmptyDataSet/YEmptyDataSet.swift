//
//  YEmptyDataSet.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/22.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

import EmptyDataSet_Swift

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }
    
    var yempty: YEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? YEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class YEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    
    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0
    
    
    private var tapClosure: (() -> Void)?
    
    init(image: UIImage? = UIImage(named: "nodata"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}
