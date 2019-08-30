//
//  AlertShowable.swift
//  engineer.ai.assignment
//
//  Created by Sergey.Sokoltsov on 8/30/19.
//  Copyright © 2019 CHISW. All rights reserved.
//

import UIKit

protocol AlertShowable {
    func showCommonAlert()
    func showAlert(_ title: String, _ message: String, completion: VoidClosure?)
    func showAlert(_ title: String?, _ message: String?, actions: [UIAlertAction])
}

extension AlertShowable where Self: UIViewController {
    func showCommonAlert() {
        let title = "commonError".localized()
        showAlert(title, "", completion: nil)
    }
    
    func showAlert(_ title: String, _ message: String, completion: VoidClosure? = nil) {
        let okTitle = "OK".localized()
        let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            completion?()
        }
        showAlert(title, message, actions: [okAction])
    }
    
    func showAlert(_ title: String?, _ message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        if self.view.window != nil {
            //            Show error only if screen is visible
            self.present(alert, animated: true, completion: nil)
        }
    }
}
