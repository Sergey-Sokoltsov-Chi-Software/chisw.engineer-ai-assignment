//
//  UIView+Extensions.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

extension UIView {

    func showActivityIndicator(animated: Bool, backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3)) {
        let kActivityIndicatorContainerTag: Int = 88005553535
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.isHidden = false
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let container = UIView(frame: bounds)
        container.tag = kActivityIndicatorContainerTag
        container.alpha = 0
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.backgroundColor = backgroundColor
        addSubview(container)
        container.addSubview(indicator)
        container.addConstraints([
            NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0),
            ])
        container.adjustVisibility(visible: true, animated: animated) {
            
        }
    }
    
    func hideActivityIndicator(animated: Bool) {
        let kActivityIndicatorContainerTag: Int = 88005553535
        guard let containerView = viewWithTag(kActivityIndicatorContainerTag) else {
            return
        }
        containerView.adjustVisibility(visible: false, animated: animated) {
            containerView.removeFromSuperview()
        }
    }
    
    func adjustVisibility(visible: Bool, animated: Bool, completion: VoidClosure?) {
        let alpha: CGFloat = visible ? 1 : 0
        UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
            self.alpha = alpha
        }, completion: { (finished) in
            completion?()
        })
    }
}
